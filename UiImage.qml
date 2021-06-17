/*
 * Copyright (C) 2020-2021 BlueStack Systems, Inc.
 * All Rights Reserved
 *
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF BLUESTACK SYSTEMS, INC.
 * The copyright notice above does not evidence any actual or intended
 * publication of such source code.
 */

import QtQuick 2.15
import QtQuick.Controls 2.15
import UiToolTipControl 1.0

Image {
    property string asset
    property string extn: ".svg"
    property int pImageWidth : 0
    property int pImageHeight : 0

    sourceSize.width: pImageWidth
    sourceSize.height: pImageHeight
    source: asset === "" ? "" : "qrcAssets/" + asset + extn
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    cache: true
    mipmap: true
    opacity: enabled ? 1 : 0.5
}
