#include "audio_controller.h"
#include <QDebug>
#include <sndfile.hh> // The C++ wrapper for libsndfile
#include <taglib/tag.h>
#include <taglib/fileref.h>
#include <QtConcurrent>
#include <QFuture>
#include <QFutureWatcher>



AudioController::AudioController(QObject *parent): QThread(parent)
{

    start();
}

QVariantMap  AudioController::loadAudio(QString path)
{
    SndfileHandle sndfile(path.toStdString().c_str()); // Open the audio file
    if (sndfile.error()) {
        qDebug() << "Error: invalid audio file";
        //return ;
    }
    SNDFILE* rawFile = sndfile.rawHandle();
    QVariantMap audioData;
    const sf_count_t totalFrames = sndfile.frames();
    const int channels = sndfile.channels();
    const int sampleRate = sndfile.samplerate();
    const int secondsToRead = static_cast<double>(totalFrames) / sampleRate; // Adjust as needed
    const int framesPerRead = qMin(totalFrames, channels * sampleRate * secondsToRead);

    audioData["secondsToRead"] = secondsToRead;
    audioData["sampleRate"] = sampleRate;
    audioData["framesPerRead"] = framesPerRead;
    audioData["numberOfChannels"] = channels;
    TagLib::FileRef Tabfile(path.toStdString().c_str());
    if (!Tabfile.isNull() && Tabfile.tag()) {
        TagLib::Tag* tag = Tabfile.tag();
        std::string title = tag->title().toCString(true);
        std::string artist = tag->artist().toCString(true);
        std::string album = tag->album().toCString(true);
        audioData["audioName"] = QString::fromStdString(title);
        audioData["artist"] = QString::fromStdString(artist);
        audioData["album"] = QString::fromStdString(album);
    } else {
        qDebug() << "Error opening file or no valid tag.";
    }

    std::vector<float> buffer(framesPerRead * channels);
    sndfile.readf(buffer.data(), framesPerRead);
    if(channels == 1){
        QVariantList channelData;
        for (int i = 0; i < framesPerRead; ++i) {
            channelData.append(buffer[i]);
        }
        audioData["channelsData"] = channelData;

    }else if(channels == 2){

        QVariantList leftChannel;
        leftChannel.reserve(framesPerRead);
        QVariantList rightChannel;
        rightChannel.reserve(framesPerRead);
        QVariantList channelData;

        for (int var = 0; var < framesPerRead; ++var) {
            leftChannel.append( buffer[var * channels]);
            rightChannel.append(buffer[var * channels + 1]);
        }
        //qDebug() << "leftChannel" << leftChannel;
        // channelData.append(leftChannel);
        // channelData.append(rightChannel);
        //audioData["channelsData"] = channelData;
        audioData["leftChannel"] = leftChannel;
        audioData["rightChannel"] = rightChannel;
    }
    return audioData;





    // return ;
}
