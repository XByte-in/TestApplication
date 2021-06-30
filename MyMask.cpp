#include "MyMask.h"
#include <QRgb>
#include <QColor>
#include <QDebug>

MyMask::MyMask(QObject *parent)
    : QObject(parent),
      QImage()
{
    QObject::connect(this, &MyMask::sourceChanged, this, [this]() { this->load(m_source); });
}

QColor MyMask::color(int x, int y)
{
    return this->pixelColor(x, y);
}

QString MyMask::source() const
{
    return m_source;
}

void MyMask::setSource(const QString &source)
{
    if (source != m_source) {
        m_source = source;
        emit sourceChanged();
    }
}
