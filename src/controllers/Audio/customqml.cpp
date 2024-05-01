#include "customqml.h"

CustomQml::CustomQml(QQuickItem *parent): QQuickPaintedItem(parent), m_duration(0.0), m_lineColor("#0000FF")
{
   // setWidth(200);
   // setHeight(100);
    //connect(this, &CustomQml::widthChanged, this, &CustomQml::handleResize);
   // connect(this, &CustomQml::heightChanged, this, &CustomQml::handleResize);
}

void CustomQml::paint(QPainter *painter)
{
    if (!m_amplitudeData.isEmpty() && m_duration > 0 ) {
        int numPoints = m_amplitudeData.size();
        double stepX = width() / (double)numPoints;

        // Find minimum and maximum values
        double minValue = *std::min_element(m_amplitudeData.begin(), m_amplitudeData.end());
        double maxValue = *std::max_element(m_amplitudeData.begin(), m_amplitudeData.end());

        // Calculate scaling factor (avoid division by zero)
        double scalingFactor = (maxValue != minValue) ? height() / (maxValue - minValue) : 1.0;

        // Pre-calculate control points
        QVector<QPointF> controlPoints1, controlPoints2;
        for (int i = 0; i < numPoints - 1; ++i) {
            double x = i * stepX;
            double scaledAmplitude = (m_amplitudeData[i] - minValue) * scalingFactor;
            double y = height() - scaledAmplitude;
            double nextX = (i + 1) * stepX;
            double nextScaledAmplitude = (m_amplitudeData[i + 1] - minValue) * scalingFactor;
            double nextY = height() - nextScaledAmplitude;

            controlPoints1.push_back(QPointF(x + stepX / 2, y));
            controlPoints2.push_back(QPointF(nextX - stepX / 2, nextY));
        }

        painter->setRenderHint(QPainter::Antialiasing, true);
        painter->setPen(m_lineColor);

        QPainterPath path;
        for (int i = 0; i < numPoints - 1; ++i) {
            double x = i * stepX;
            double scaledAmplitude = (m_amplitudeData[i] - minValue) * scalingFactor;
            double y = height() - scaledAmplitude;
            path.moveTo(QPointF(x, y));
            path.cubicTo(controlPoints1[i], controlPoints2[i], QPointF((i + 1) * stepX, height() - (m_amplitudeData[i + 1] - minValue) * scalingFactor));
        }       
        currentDraw = new QPainterPath(path);
        painter->drawPath(path);
        dataChanged = false;
    }
    // else{
    //     if(currentDraw != nullptr){
    //         //painter->setRenderHint(QPainter::Antialiasing, true);
    //         painter->setPen(m_lineColor);
    //         painter->drawPath(*currentDraw);
    //     }
    // }

}

QList<double> CustomQml::amplitudeData() const
{
    return m_amplitudeData;
}

void CustomQml::setAmplitudeData(const QList<double> &data)
{
    if (m_amplitudeData != data) {
        m_amplitudeData = data;
        emit amplitudeDataChanged();
        dataChanged = true;
        update(); // Trigger a repaint
    }
}

double CustomQml::duration() const
{
    return m_duration;
}

void CustomQml::setDuration(double duration)
{
    if (qFuzzyCompare(m_duration, duration))
        return;

    m_duration = duration;
    emit durationChanged();
    update(); // Trigger a repaint
}

void CustomQml::handleResize()
{

}
QString CustomQml::lineColor() const
{
    return m_lineColor.name();
}

void CustomQml::setLineColor(const QString &color)
{
    m_lineColor = QColor(color);
    emit lineColorChanged();
    update();
}
