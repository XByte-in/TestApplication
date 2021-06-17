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
import QtQuick.Window 2.15
import QtQuick.Shapes 1.12

TextField {
    id: iControl

    enum InputValidation {
        Valid,
        Warning,
        Error
    }

    property QtObject pSize
    property QtObject pColor: UiTheme.textFields.colors.accent
    property QtObject pColorState: pInputValidationState === UiTextField.InputValidation.Error ?
                                       pColor.error : pInputValidationState === UiTextField.InputValidation.Warning ?
                                           pColor.warning : activeFocus ?
                                               pColor.active : hovered ?
                                                   pColor.hover : pColor.normal
    property int pInputValidationState: UiTextField.InputValidation.Valid

    property bool pOpenErrorTemplate: false
    property string pErrorTemplateContent: ""
    property var pErrorTemplate: null

    implicitHeight: pSize.height

    leftPadding: pSize.horizontalPadding
    rightPadding: pSize.horizontalPadding
    topPadding: 0
    bottomPadding: 0

    font: pSize.textFont
    selectionColor: pColor.selection
    selectedTextColor: pColor.selectionText

    color: pColorState.textColor
    placeholderTextColor: pColorState.textColor

    background: Rectangle {
        color: iControl.pColorState.background
        border.width: 1
        border.color: iControl.pColorState.border
    }

    onActiveFocusChanged: {
        iControl.ensureVisible(0)
    }

    onPOpenErrorTemplateChanged: {
        if (iControl.pOpenErrorTemplate) {
            if (iControl.pErrorTemplate === null) {
                iControl.pErrorTemplate = errorComponent.createObject(null, { pErrorContent: iControl.pErrorTemplateContent })

                iControl.pErrorTemplate.screen = fGetCurrentScreen()
                var point = mapToGlobal(0, 0)
                iControl.pErrorTemplate.x = point.x - pErrorTemplate.width / 2 + width / 2
                iControl.pErrorTemplate.y = point.y - pErrorTemplate.height
                iControl.pErrorTemplate.show()
            }
        } else {
            if (iControl.pErrorTemplate !== null) {
                iControl.pErrorTemplate.closePopup()
            }
        }
    }

    Component {
        id: errorComponent
        UiHelpPopup {
            property string pErrorContent: ""

            contentWidth: pInnerLayout.implicitWidth
            contentHeight: 30
            closeOnPressOutside: false
            flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowDoesNotAcceptFocus
            pInnerLayout {
                border.width: 1
                border.color: UiTheme.colors.dangerNormal
                color: UiTheme.colors.primary90
                padding: 4
            }

            Text {
                text: pErrorContent
                font: UiTheme.fonts.bodyMedium
                color: UiTheme.colors.primary10
            }
        }
    }

    function fGetCurrentScreen()
    {
        for (var i = 0; i < Qt.application.screens.length; i++)
        {
            if (Qt.application.screens[i].name === Screen.name)
            {
                return Qt.application.screens[i]
            }
        }
    }
}
