#ifndef MUSICPROJECT_H
#define MUSICPROJECT_H

#include <QObject>
#include "./project.h"
#include <QSettings>
#include "../../../controllers/Audio/audio_controller.h"
#include "audio_sample.h"
#include  <QDataStream>
#include <QFile>


class MusicProject : public Project
{
    Q_OBJECT



    Q_PROPERTY(AudioController *audioController READ getAudioController NOTIFY audioControllerChanged)
    Q_PROPERTY(AudioSample *currentAudioSample READ getCurrentAudioSample WRITE setCurrentAudioSample NOTIFY currentAudioSampleChanged)
    Q_PROPERTY(QList<AudioSample*> audioSamples READ getAudioSamples NOTIFY audioSamplesChanged)

public:
    using Project::Project;
    MusicProject(QObject *parent = nullptr);

    Q_INVOKABLE bool loadProjectFromLocalStorage(QString projectPath) override;
    Q_INVOKABLE void saveProjectToLocalStorage() override;
    Q_INVOKABLE void deleteProjectFromLocalStorage() override;
    Q_INVOKABLE void saveAudioSamplesToLocalStorage();
    Q_INVOKABLE void loadAudioSamplesFromLocalStorage();
    Q_INVOKABLE bool saveAudioSampleToLocalStorage(AudioSample* audioSample);

public slots:
    Q_INVOKABLE AudioController* getAudioController();
    Q_INVOKABLE AudioSample* getCurrentAudioSample();
    Q_INVOKABLE void setCurrentAudioSample(AudioSample* audioSample);
    Q_INVOKABLE QList<AudioSample*> getAudioSamples();
    Q_INVOKABLE bool addAudioSample(AudioSample* audioSample);
    Q_INVOKABLE bool deleteAudioSample(AudioSample* audioSample);
    Q_INVOKABLE bool updateAudioSample(AudioSample* audioSample);



private:
    QSettings* projectSettings;
    AudioController* audioController = new AudioController();
    AudioSample* currentAudioSample = nullptr;
    QList<AudioSample*> audioSamples;

signals:
    void audioControllerChanged();
    void currentAudioSampleChanged();
    void audioSamplesChanged();
    void audioSampleAdded(AudioSample* audioSample);

};
// Register the meta type for QList<AudioSample*>

//Q_DECLARE_METATYPE(QList<AudioSample*>)


// // Serialization operator for AudioSample pointers
// QDataStream& operator<<(QDataStream& out, const AudioSample* audioSample) {
//     out << audioSample->fileName << audioSample->filePath << audioSample->audioName << audioSample->audioArtist << audioSample->audioAlbum << audioSample->channels << audioSample->sampleRate << audioSample->secondsToRead << audioSample->framesPerRead;
//     return out;
// }

// // Deserialization operator for AudioSample pointers
// QDataStream& operator>>(QDataStream& in, AudioSample*& audioSample) {
//     audioSample = new AudioSample;

//     in >> audioSample->fileName >> audioSample->filePath >> audioSample->audioName >> audioSample->audioArtist >> audioSample->audioAlbum >> audioSample->channels >> audioSample->sampleRate >> audioSample->secondsToRead >> audioSample->framesPerRead;
//     //in >> project->name >> project->description >> project->id;
//     return in;
// }
#endif // MUSICPROJECT_H
