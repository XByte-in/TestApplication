#ifndef MASKEDMOUSEAREA_H
#define MASKEDMOUSEAREA_H
#include <QImage>
#include <QQuickItem>
class MaskedMouseArea : public QQuickItem {
    Q_OBJECT
    Q_PROPERTY(bool pressed READ isPressed NOTIFY pressedChanged)
    Q_PROPERTY(QUrl maskSource READ maskSource WRITE setMaskSource NOTIFY maskSourceChanged)
    Q_PROPERTY(qreal alphaThreshold READ alphaThreshold WRITE setAlphaThreshold NOTIFY alphaThresholdChanged)

public:
    MaskedMouseArea(QQuickItem *parent = 0);
    bool isPressed() const { return m_pressed; }
    QUrl maskSource() const { return m_maskSource; }
    void setMaskSource(const QUrl &source);
    qreal alphaThreshold() const { return m_alphaThreshold; }
    void setAlphaThreshold(qreal threshold);

signals:
    void pressed();
    void released();
    void clicked(QMouseEvent *event);
    void canceled();
    void pressedChanged();
    void maskSourceChanged();
    void alphaThresholdChanged();

protected:
    void setPressed(bool pressed);
    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void hoverEnterEvent(QHoverEvent *event);
    void hoverLeaveEvent(QHoverEvent *event);
    void mouseUngrabEvent();

private:
    bool m_pressed;
    QUrl m_maskSource;
    QImage m_maskImage;
    QPointF m_pressPoint;
    qreal m_alphaThreshold;
};
#endif
