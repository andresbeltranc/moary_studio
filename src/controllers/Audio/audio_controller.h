#ifndef AUDIOEXTRACTOR_H
#define AUDIOEXTRACTOR_H

#include <QObject>
#include <QVariant>
#include "audiodata.h"
class AudioController : public QObject
{
    Q_OBJECT
public:
    AudioController(QObject *parent = nullptr);

public slots:
    QVariantMap loadAudio(QString path);
};

#endif // AUDIOEXTRACTOR_H
