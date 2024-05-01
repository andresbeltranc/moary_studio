#ifndef CUSTOMQML_H
#define CUSTOMQML_H
#include <QQuickPaintedItem>
#include <QPainter>
#include <QPointF>
#include <QPainterPath>

class CustomQml : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QList<double> amplitudeData READ amplitudeData WRITE setAmplitudeData NOTIFY amplitudeDataChanged)
    Q_PROPERTY(double duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(QString lineColor READ lineColor WRITE setLineColor NOTIFY lineColorChanged)

public:
    CustomQml(QQuickItem *parent = nullptr);
    void paint(QPainter *painter) override;
    QList<double> amplitudeData() const;
    void setAmplitudeData(const QList<double> &data);
    QString lineColor() const;
    void setLineColor(const QString &color);
    double duration() const;
    void setDuration(double duration);
    void handleResize();

signals:
    void amplitudeDataChanged();
    void durationChanged();
    void lineColorChanged();

private:
    QList<double> m_amplitudeData;
    double m_duration;
    QColor m_lineColor;
    QPainterPath *currentDraw = nullptr;
    bool dataChanged = false;

};

#endif // CUSTOMQML_H
