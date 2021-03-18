#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>
#include <WINDOWSX.H>
#include <QScreen>
#include <QDirIterator>
#include <QDir>
#include <QClipboard>
#include <QDateTime>
#include <QTimeZone>
#include <QTranslator>
#include <QQmlComponent>

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine* engine  =new QQmlApplicationEngine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
   // engine->rootContext()->setContextProperty("UiTheme", UiTheme::instance());
    QObject::connect(engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine->load(url);

    return app.exec();
}
