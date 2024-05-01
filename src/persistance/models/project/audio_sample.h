#ifndef AUDIOSAMPLES_H
#define AUDIOSAMPLES_H

#include <QObject>
#include <QQmlEngine>


class AudioSample : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString fileName READ getFileName WRITE setFileName NOTIFY fileNameChanged)
    Q_PROPERTY(QString filePath READ getFilePath WRITE setFilePath NOTIFY filePathChanged)
    Q_PROPERTY(QString audioName READ getAudioName WRITE setAudioName NOTIFY audioNameChanged)
    Q_PROPERTY(QString audioArtist READ getAudioArtist WRITE setAudioArtist NOTIFY audioArtistChanged)
    Q_PROPERTY(QString audioAlbum READ getAudioAlbum WRITE setAudioAlbum NOTIFY audioAlbumChanged)
    Q_PROPERTY(int channels READ getChannels WRITE setChannels NOTIFY channelsChanged)
    Q_PROPERTY(int sampleRate READ getSampleRate WRITE setSampleRate NOTIFY sampleRateChanged)
    Q_PROPERTY(int secondsToRead READ getSecondsToRead WRITE setSecondsToRead NOTIFY secondsToReadChanged)
    Q_PROPERTY(int framesPerRead READ getFramesPerRead WRITE setFramesPerRead NOTIFY framesPerReadChanged)
    Q_PROPERTY(std::vector<float> dataBuffer READ getDataBuffer WRITE setDataBuffer NOTIFY dataBufferChanged)
    Q_PROPERTY(std::vector<float> interpolatedData READ getInterpolatedData WRITE setInterpolatedData NOTIFY interpolatedDataChanged);
    Q_PROPERTY(QVariantList interpolatedDataList READ getInterpolatedDataList NOTIFY interpolatedDataListChanged)

    QML_VALUE_TYPE(audioSample)


public:
    explicit AudioSample(QObject *parent = nullptr);

    // getters and setters
    Q_INVOKABLE QString getFileName();
    Q_INVOKABLE void setFileName(const QString &value);
    Q_INVOKABLE QString getFilePath();
    Q_INVOKABLE void setFilePath(const QString &value);
    Q_INVOKABLE QString getAudioName() ;
    Q_INVOKABLE void setAudioName(const QString &value);
    Q_INVOKABLE QString getAudioArtist() ;
    Q_INVOKABLE void setAudioArtist(const QString &value);
    Q_INVOKABLE QString getAudioAlbum() ;
    Q_INVOKABLE void setAudioAlbum(const QString &value);
    Q_INVOKABLE int getChannels() ;
    Q_INVOKABLE void setChannels(int value);
    Q_INVOKABLE int getSampleRate() ;
    Q_INVOKABLE void setSampleRate(int value);
    Q_INVOKABLE int getSecondsToRead() ;
    Q_INVOKABLE void setSecondsToRead(int value);
    Q_INVOKABLE int getFramesPerRead() ;
    Q_INVOKABLE void setFramesPerRead(int value);
    Q_INVOKABLE std::vector<float> getDataBuffer() ;
    Q_INVOKABLE void setDataBuffer(const std::vector<float> &value);
    Q_INVOKABLE std::vector<float> getInterpolatedData();
    Q_INVOKABLE void setInterpolatedData(const std::vector<float> &value);
    Q_INVOKABLE QVariantList getInterpolatedDataList() const;
    Q_INVOKABLE void setInterpolatedDataList(const QVariantList &newInterpolatedDataList);


private:
    QString fileName;
    QString filePath;
    QString audioName;
    QString audioArtist;
    QString audioAlbum;
    int channels;
    int sampleRate;
    int secondsToRead;
    int framesPerRead;
    std::vector<float>dataBuffer;
    std::vector<float> interpolatedData;
    QVariantList interpolatedDataList;

signals:
    void fileNameChanged();
    void filePathChanged();
    void audioNameChanged();
    void audioArtistChanged();
    void audioAlbumChanged();
    void channelsChanged();
    void sampleRateChanged();
    void secondsToReadChanged();
    void framesPerReadChanged();
    void dataBufferChanged();
    void interpolatedDataChanged();
    void interpolatedDataListChanged();


};



#endif // AUDIOSAMPLES_H
