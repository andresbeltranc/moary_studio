#ifndef AUDIOEXTRACTOR_H
#define AUDIOEXTRACTOR_H

#include <QObject>
#include <QVariant>
#include <QMutex>
#include <QThread>
#include "../../persistance/models/project/audio_sample.h"

class AudioController : public QObject
{
    Q_OBJECT
public:
    explicit AudioController(QObject *parent = nullptr);

    std::vector<float> linear_interpolation(const std::vector<float> &original_data, int num_interpolated_points);
public slots:
    AudioSample* getAudioSampleFromFile(QString path);
};

#endif // AUDIOEXTRACTOR_H
