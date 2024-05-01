#include "audio_controller.h"
#include <QDebug>
#include <sndfile.hh> // The C++ wrapper for libsndfile
#include <taglib/tag.h>
#include <taglib/fileref.h>
#include <QtConcurrent>
#include <QFuture>
#include <QFutureWatcher>





AudioController::AudioController(QObject *parent)
{

}

std::vector<float> AudioController::linear_interpolation(const std::vector<float>& original_data, int num_interpolated_points) {
    qDebug() << "linear_interpolation";
    std::vector<float> interpolated_data(num_interpolated_points);

    // Create an array of indices for the original data
    qDebug() << "Create an array of indices for the original data";

    std::vector<float> indices(original_data.size());
    for (size_t i = 0; i < original_data.size(); ++i) {
        indices[i] = static_cast<float>(i);
    }
    qDebug() << "indices S" << indices.size();

    // Create an array of indices for the interpolated data
    qDebug() << "Create an array of indices for the interpolated data";
    std::vector<float> interpolated_indices(num_interpolated_points);
    for (int i = 0; i < num_interpolated_points; ++i) {
        interpolated_indices[i] = i * (original_data.size() - 1) / static_cast<float>(num_interpolated_points - 1);
    }

    qDebug() << "interpolated_indices S" << interpolated_indices.size();
    // Perform linear interpolation
    qDebug() << "Perform linear interpolation";

    // Perform linear interpolation
    for (int i = 0; i < num_interpolated_points; ++i) {
        float index = interpolated_indices[i];
        size_t lower_index = static_cast<size_t>(index);
        size_t upper_index = std::min(lower_index + 1, original_data.size() - 1);  // Ensure upper index is within bounds
        float t = index - lower_index;

        interpolated_data[i] = (1.0f - t) * original_data[lower_index] + t * original_data[upper_index];
    }

    return interpolated_data;
}




AudioSample* AudioController::getAudioSampleFromFile(QString path)
{
    SndfileHandle sndfile(path.toStdString().c_str()); // Open the audio file
    if (sndfile.error()) {
        qDebug() << "Error: invalid audio file";
        //return ;
    }
    std::filesystem::path filePath(path.toStdString().c_str());
    std::string fileName = filePath.filename().string();
    AudioSample *audioSample = new AudioSample();
    SNDFILE* rawFile = sndfile.rawHandle();
    QVariantMap audioData;
    const sf_count_t totalFrames = sndfile.frames();
    const int channels = sndfile.channels();
    const int sampleRate = sndfile.samplerate();
    const int secondsToRead = static_cast<double>(totalFrames) / sampleRate; // Adjust as needed
    const int framesPerRead = qMin(totalFrames, channels * sampleRate * secondsToRead);

    audioSample->setFileName(QString::fromStdString(fileName));
    audioSample->setFilePath(path);
    audioSample->setChannels(channels);
    audioSample->setSampleRate(sampleRate);
    audioSample->setSecondsToRead(secondsToRead);
    audioSample->setFramesPerRead(framesPerRead);

    TagLib::FileRef Tabfile(path.toStdString().c_str());
    if (!Tabfile.isNull() && Tabfile.tag()) {
        TagLib::Tag* tag = Tabfile.tag();
        std::string title = tag->title().toCString(true);
        std::string artist = tag->artist().toCString(true);
        std::string album = tag->album().toCString(true);
        audioSample->setAudioName(QString::fromStdString(title));
        audioSample->setAudioArtist(QString::fromStdString(artist));
        audioSample->setAudioAlbum(QString::fromStdString(album));
    } else {
        qDebug() << "Error opening file or no valid tag.";
    }

    std::vector<float> buffer(framesPerRead * channels);
    sndfile.readf(buffer.data(), framesPerRead);
    QVariantList channelData;
    if(channels == 1){
        std::vector<float> interpolated_buffer = linear_interpolation(buffer, 500);
        for (int i = 0; i < interpolated_buffer.size(); ++i) {
            channelData.append(QVariant(interpolated_buffer[i]));
        }
        audioSample->setDataBuffer(buffer);
        audioSample->setInterpolatedData(interpolated_buffer);
        audioSample->setInterpolatedDataList(channelData);


    }else if(channels == 2){
        std::vector<float> monoChannel;
        monoChannel.reserve(framesPerRead);
        for (int var = 0; var < framesPerRead; ++var) {
            float leftSample = buffer[var * channels];
            float rightSample = buffer[var * channels + 1];
            float monoSample = (leftSample + rightSample) / 2;
            monoChannel.push_back(monoSample);
        }
        std::vector<float> interpolated_buffer = linear_interpolation(buffer, 500);
        for (int i = 0; i < interpolated_buffer.size(); ++i) {
            channelData.append(QVariant(interpolated_buffer[i]));
        }
        audioSample->setDataBuffer(monoChannel);
        audioSample->setInterpolatedData(interpolated_buffer);
        audioSample->setInterpolatedDataList(channelData);

    }
    return audioSample;

}
