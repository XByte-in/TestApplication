#include <QScreen>
#include <QGuiApplication>
#include <QtQuick/QQuickView>
#include <QLoggingCategory>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlContext>
#include <QQuickWindow>
#include <QSettings>
#include <QVariant>
#include <QVariantList>
#include <QtPlatformHeaders/QWindowsWindowFunctions>
#include <dxgi.h>
#include <d3d11.h>
#include "qsgrendererinterface.h"
#include <QElapsedTimer>
#include "directoryvalidator.h"
#include "UiToolTip.h"
#include "UiTheme.h"
#include "UiDialogButtonModel.h"
#include "UiDialogButtonModelList.h"
#include "mainbackend.h"

#define getQObject(a, b) qvariant_cast<QObject*>(a->property(b))

#pragma comment(lib, "dxgi.lib")

std::vector<IDXGIAdapter*> plrGetGpuList()
{
    IDXGIFactory1* pFactory = NULL;
    IDXGIAdapter* pAdapter = NULL;
    std::vector<IDXGIAdapter*> vAdapters;

    if (FAILED(CreateDXGIFactory1(__uuidof(IDXGIFactory1), (void**)&pFactory)))
    {
        return vAdapters;
    }

    for (UINT i = 0; pFactory->EnumAdapters(i, &pAdapter) != DXGI_ERROR_NOT_FOUND; ++i)
    {
        DXGI_ADAPTER_DESC adapterDesc;
        pAdapter->GetDesc(&adapterDesc);

        if (adapterDesc.VendorId == 0x1414 && adapterDesc.DeviceId == 0x8c)
            continue; // Skip Microsoft Basic Render Driver

        //XLOGI("--------GPU %d: %S (Vendor %04x Device %04x SubSysId %04x Revision %04x)\n", i, adapterDesc.Description, adapterDesc.VendorId, adapterDesc.DeviceId, adapterDesc.SubSysId, adapterDesc.Revision);
        vAdapters.push_back(pAdapter);
    }

    if (pFactory)
    {
        pFactory->Release();
    }
    return vAdapters;
}

QSGRendererInterface::GraphicsApi plrQtRendererStringToEnum(std::string rendererString)
{
    if (rendererString == "Software")
        return QSGRendererInterface::Software;
    else if (rendererString == "OpenGL")
        return QSGRendererInterface::OpenGL;
    else if (rendererString == "Direct3D12")
        return QSGRendererInterface::Direct3D12;
    else if (rendererString == "OpenVG")
        return QSGRendererInterface::OpenVG;
    else if (rendererString == "OpenGLRhi")
        return QSGRendererInterface::OpenGLRhi;
    else if (rendererString == "Direct3D11Rhi")
        return QSGRendererInterface::Direct3D11Rhi;
    else if (rendererString == "VulkanRhi")
        return QSGRendererInterface::VulkanRhi;
    else if (rendererString == "MetalRhi")
        return QSGRendererInterface::MetalRhi;
    else
        return QSGRendererInterface::Unknown;
}

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
    QGuiApplication app(argc, argv);

    qmlRegisterType<DirectoryValidator>("DirValidator", 1, 0, "DirValidator");
    qmlRegisterType<UiToolTip>("UiToolTipControl", 1, 0, "UiToolTip");
    qmlRegisterType<UiDialogButtonModelList>("DialogButtonModelList", 1, 0, "DialogButtonModelList");
    qmlRegisterType<UiDialogButtonModel>("DialogButtonModel", 1, 0, "DialogButtonModel");

    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Direct3D11Rhi);

    QQmlApplicationEngine* engine = new QQmlApplicationEngine;
    engine->rootContext()->setContextProperty("UiTheme", UiTheme::instance());

    MainBackend* mainBackend = new MainBackend;
    engine->rootContext()->setContextProperty("mainBackend", mainBackend);
    engine->load(QUrl("qrc:/main.qml"));




    QObject* qmlRoot = engine->rootObjects().first();
    QQuickWindow* mainWindow = qobject_cast<QQuickWindow*>(qmlRoot);

    //QMetaObject::invokeMethod(mainWindow, "fSetTitle");

    QScreen* screen = QGuiApplication::primaryScreen();
    QRect  screenGeometry = screen->availableGeometry();

//    qInfo()<<screenGeometry.width();
//    qInfo()<<screenGeometry.height();
    return app.exec();
}
