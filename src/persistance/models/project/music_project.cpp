#include "music_project.h"


MusicProject::MusicProject(QObject *parent)
{
}

bool MusicProject::loadProjectFromLocalStorage(QString projectPath)
{

    qDebug() << "loadProjectFromLocalStorage";
    qDebug() << "projectPath" << projectPath;
    projectSettings = new QSettings(projectPath,QSettings::IniFormat);
    this->setProjectType(ProjectType::MUSIC_PROJECT);
    qDebug() << "projectSettings Name" << projectSettings->value("name").toString();
    this->setName(projectSettings->value("name").toString());
    this->setPath(projectSettings->value("path").toString());
    this->setOwner(projectSettings->value("owner").toString());
    this->setCreationDate(projectSettings->value("creationDate").toDateTime());
    this->setLastModifiedDate(projectSettings->value("lastModifiedDate").toDateTime());
    return true;
}

void MusicProject::saveProjectToLocalStorage()
{
    qDebug() << "saveProjectToLocalStorage";
    if(projectSettings == nullptr){
        qDebug() << "projectSettings == nullptr";
        qDebug() << "getPath()" << getPath();
    }
    qDebug() << "getPath()" << getPath();
    qDebug() << "getName()" << getName();

    projectSettings = new QSettings(getPath()+"/"+getName()+"/"+getName()+".ini",QSettings::IniFormat);


    projectSettings->setValue("name",getName());
    projectSettings->setValue("path",getPath());
    projectSettings->setValue("owner",getOwner());
    projectSettings->setValue("creationDate",getCreationDate());
    projectSettings->setValue("lastModifiedDate",getLastModifiedDate());
}

void MusicProject::deleteProjectFromLocalStorage()
{

}

void MusicProject::saveAudioSamplesToLocalStorage()
{
    for (AudioSample* audioSample : audioSamples) {
        saveAudioSampleToLocalStorage(audioSample);
    }
}

void MusicProject::loadAudioSamplesFromLocalStorage()
{
    projectSettings->beginGroup("audioSamples");
    const QStringList keys = projectSettings->childGroups();
    for (const QString &audioSampleKey : keys) {
        qDebug() << "audioSampleKey: " << audioSampleKey;
        projectSettings->beginGroup(audioSampleKey);
        AudioSample *audioSample = new AudioSample();
        audioSample->setFileName(audioSampleKey);
        audioSample->setFilePath(projectSettings->value("filePath").toString());
        audioSample->setAudioName(projectSettings->value("audioName").toString());
        audioSample->setAudioArtist(projectSettings->value("audioArtist").toString());
        audioSample->setAudioAlbum(projectSettings->value("audioAlbum").toString());
        audioSample->setChannels(projectSettings->value("channels").toInt());
        audioSample->setSampleRate(projectSettings->value("sampleRate").toInt());
        audioSample->setSecondsToRead(projectSettings->value("secondsToRead").toInt());
        audioSample->setFramesPerRead(projectSettings->value("framesPerRead").toInt());
        addAudioSample(audioSample);
        projectSettings->endGroup();
    }
    projectSettings->endGroup();
    qDebug() << "laudioSamples end"<< audioSamples;
    for (int var = 0; var < audioSamples.length(); ++var) {
        qDebug() << "audioSample name"<< audioSamples[var]->getFileName();

    }

}

bool MusicProject::saveAudioSampleToLocalStorage(AudioSample *audioSample)
{
    qDebug() << "saveAudioSampleToLocalStorage";
    projectSettings->beginGroup("audioSamples");
        projectSettings->beginGroup(audioSample->getFileName());
            projectSettings->setValue("/filePath",audioSample->getFilePath());
            projectSettings->setValue("/audioName",audioSample->getAudioName());
            projectSettings->setValue("/audioArtist",audioSample->getAudioArtist());
            projectSettings->setValue("/audioAlbum",audioSample->getAudioAlbum());
            projectSettings->setValue("/channels",audioSample->getChannels());
            projectSettings->setValue("/sampleRate",audioSample->getSampleRate());
            projectSettings->setValue("/secondsToRead",audioSample->getSecondsToRead());
            projectSettings->setValue("/framesPerRead",audioSample->getFramesPerRead());
        projectSettings->endGroup();
    projectSettings->endGroup();
    qDebug() << "saveAudioSampleToLocalStorage end";

    return true;
}


AudioController *MusicProject::getAudioController()
{
    return audioController;
}

AudioSample *MusicProject::getCurrentAudioSample()
{
    return currentAudioSample;
}

void MusicProject::setCurrentAudioSample(AudioSample *audioSample)
{
    currentAudioSample = audioSample;
    emit currentAudioSampleChanged();
}

QList<AudioSample *> MusicProject::getAudioSamples()
{
    return audioSamples;
}

bool MusicProject::addAudioSample(AudioSample *audioSample)
{
    if(audioSamples.contains(audioSample)){

        return false;
    }
    audioSamples.append(audioSample);
    saveAudioSampleToLocalStorage(audioSample);
    emit audioSampleAdded(audioSample);
    emit audioSamplesChanged();
    return true;
}

bool MusicProject::deleteAudioSample(AudioSample *audioSample)
{
    audioSamples.removeOne(audioSample);
    projectSettings->beginGroup("audioSamples");
        projectSettings->remove(audioSample->getFileName());
    projectSettings->endGroup();
    emit audioSamplesChanged();
    return true;

}

bool MusicProject::updateAudioSample(AudioSample *audioSample)
{
    saveAudioSampleToLocalStorage(audioSample);
    return true;
}



