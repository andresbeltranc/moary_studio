#ifndef AUDIOEXTRACTOR_H
#define AUDIOEXTRACTOR_H

#include <QObject>
#include <QVariant>
#include <QMutex>
#include <QThread>

class AudioController : public QThread
{
    Q_OBJECT
public:
    explicit AudioController(QObject *parent = nullptr);

public slots:
    QVariantMap loadAudio(QString path);
};

#endif // AUDIOEXTRACTOR_H
