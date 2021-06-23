/*
 * Copyright (C) 2020-2021 BlueStack Systems, Inc.
 * All Rights Reserved
 *
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF BLUESTACK SYSTEMS, INC.
 * The copyright notice above does not evidence any actual or intended
 * publication of such source code.
 */
import QtQuick 2.15

QtObject {
    property string pElementId
    property string pAsset
    property string pTooltipText
    property string pConfShortcutProperty
    property bool pIsFeatureEnable: true
    property bool pIsEnable: true
    property bool pShowViaRepaterOnly: true
    property bool pShowOnKebabMenu: false

    signal clicked()
}
