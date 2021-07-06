#include "MaskedMouseArea.h"
#include <QStyleHints>
#include <QGuiApplication>
#include <QCursor>
#include <qqmlfile.h>

MaskedMouseArea::MaskedMouseArea(QQuickItem *parent) : QQuickItem(parent), m_pressed(false), m_alphaThreshold(0.0) {
    setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::LeftButton);
}

void MaskedMouseArea::setPressed(bool pressed) {
    if (m_pressed != pressed) {
        m_pressed = pressed;
        emit pressedChanged();
    }
}

void MaskedMouseArea::setMaskSource(const QUrl &source) {
    if (m_maskSource != source) {
        m_maskSource = source;
        m_maskImage = QImage(QQmlFile::urlToLocalFileOrQrc(source));
        emit maskSourceChanged();
    }
}

void MaskedMouseArea::setAlphaThreshold(qreal threshold) {
    if (m_alphaThreshold != threshold) {
        m_alphaThreshold = threshold;
        emit alphaThresholdChanged();
    }
}

void MaskedMouseArea::mousePressEvent(QMouseEvent *event) {
    setPressed(true);
    m_pressPoint = event->pos();
    emit pressed();
}

void MaskedMouseArea::mouseReleaseEvent(QMouseEvent *event) {
    setPressed(false);
    emit released();

    qInfo() << "This Width" <<this->size().width();
    qInfo() << "This Height" <<this->size().height();
    qInfo() <<"Image W.H: "<<m_maskImage.width()<<"x"<<m_maskImage.height();

    int x = m_pressPoint.rx() * m_maskImage.width() / this->size().width();
    int y = m_pressPoint.ry() * m_maskImage.height() / this->size().height();

    qInfo() <<"Mouse X.Y: "<<x<<"y"<<y;

    if (x >= 0 && x <= m_maskImage.width() && y >= 0 && y <= m_maskImage.height()) {
        int alpha = qAlpha(m_maskImage.pixel(x, y));
        qInfo()<< "Alpha: "<<alpha;
//        if(alpha < 10)
//            event->ignore();
    }
    emit clicked(event);
}

void MaskedMouseArea::mouseUngrabEvent() {
    setPressed(false);
    emit canceled();
}

void MaskedMouseArea::hoverEnterEvent(QHoverEvent *event) {
    Q_UNUSED(event);
}

void MaskedMouseArea::hoverLeaveEvent(QHoverEvent *event) {
    Q_UNUSED(event);
}
