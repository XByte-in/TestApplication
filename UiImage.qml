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

Image {
    property string asset
    property string extn: ".svg"
    source: visible ? ((extn === ".svg") ? "svg/" : "") + asset + extn : ""
    sourceSize.width: (extn === ".svg") ? width : undefined
    sourceSize.height: (extn === ".svg") ? height : undefined
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    cache: true
    mipmap: true
    opacity: enabled ? 1 : 0.5
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

