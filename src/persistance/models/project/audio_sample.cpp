#include "audio_sample.h"

AudioSample::AudioSample(QObject *parent)
    : QObject{parent}
{}

QString AudioSample::getFileName()
{
    return fileName;

}

void AudioSample::setFileName(const QString &value)
{
    fileName = value;
    emit fileNameChanged();
}


// Getters and setters
QString AudioSample::getFilePath()
{
    return filePath;
}

void AudioSample::setFilePath(const QString &value)
{
    filePath = value;
    emit filePathChanged();
}

QString AudioSample::getAudioName()
{
    return audioName;
}

void AudioSample::setAudioName(const QString &value)
{
    audioName = value;
    emit audioNameChanged();

}

QString AudioSample::getAudioArtist()
{
    return audioArtist;
}

void AudioSample::setAudioArtist(const QString &value)
{
    audioArtist = value;
    emit audioArtistChanged();

}

QString AudioSample::getAudioAlbum()
{
    return audioAlbum;
}

void AudioSample::setAudioAlbum(const QString &value)
{
    audioAlbum = value;
    emit audioAlbumChanged();

}

int AudioSample::getChannels()
{
    return channels;
}

void AudioSample::setChannels(int value)
{
    channels = value;
    emit channelsChanged();

}

int AudioSample::getSampleRate()
{
    return sampleRate;
}

void AudioSample::setSampleRate(int value)
{
    sampleRate = value;
    emit sampleRateChanged();

}

int AudioSample::getSecondsToRead()
{
    return secondsToRead;
}

void AudioSample::setSecondsToRead(int value)
{
    secondsToRead = value;
    emit secondsToReadChanged();

}

int AudioSample::getFramesPerRead()
{
    return framesPerRead;
}

void AudioSample::setFramesPerRead(int value)
{
    framesPerRead = value;
    emit framesPerReadChanged();
}

std::vector<float> AudioSample::getDataBuffer()
{
    return dataBuffer;
}

void AudioSample::setDataBuffer(const std::vector<float> &value)
{
    dataBuffer = value;
    emit dataBufferChanged();
}

std::vector<float> AudioSample::getInterpolatedData()
{
    return interpolatedData;
}

void AudioSample::setInterpolatedData(const std::vector<float> &value)
{
    interpolatedData = value;
    emit interpolatedDataChanged();
}

QVariantList AudioSample::getInterpolatedDataList() const
{
    return interpolatedDataList;
}

void AudioSample::setInterpolatedDataList(const QVariantList &newInterpolatedDataList)
{
    interpolatedDataList = newInterpolatedDataList;
    emit interpolatedDataListChanged();
}

