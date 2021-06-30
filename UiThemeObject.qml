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
    property QtObject colors: QtObject {
        property color primary100: "#080A1F"
        property color primary90: "#1B1E38"
        property color primary80: "#232642"
        property color primary70: "#2B2E4C"
        property color primary60: "#373A58"
        property color primary50: "#434664"
        property color primary40: "#565977"
        property color primary30: "#7F82A0"
        property color primary20: "#B6B8CD"
        property color primary10: "#F7FAFF"

        property color accentNormal: "#1A90FF"
        property color accentHover: "#2EA4FF"
        property color accentClick: "#057CEB"

        property color secondaryNormal: "#F7FAFF"
        property color secondaryHover: "#FFFFFF"
        property color secondaryClick: "#EDF0F5"

        property color tertiaryNormal: primary50
        property color tertiaryHover: primary40
        property color tertiaryClick: primary60

        property color dangerNormal: "#EB553E"
        property color dangerHover: "#FF6952"
        property color dangerClick: "#D7412A"

        property color notice: "#AA00FF"
        property color success: "#78D62F"
        property color warning: "#FFB54D"
        property color error: "#EB5D3E"

        property color overlayPrimary: "#D9080A1F"
        property color overLayBlack: "#CC000000"
        property color overLayGray: "#99000000"
        property color overLayBright: "#99FFFFFF"
        property color overLayTint: "#33FFFFFF"
    }

    property QtObject fonts: QtObject {
        property font titleExtraLarge: Qt.font({
                                                   "family": "Rubik",
                                                   "styleName": "Medium",
                                                   "pixelSize": 24
                                               })
        property font titleLarge: Qt.font({
                                              "family": "Rubik",
                                              "styleName": "Medium",
                                              "pixelSize": 18
                                          })
        property font titleMedium: Qt.font({
                                               "family": "Rubik",
                                               "styleName": "Medium",
                                               "pixelSize": 16
                                           })
        property font titleSmall: Qt.font({
                                              "family": "Rubik",
                                              "styleName": "Medium",
                                              "pixelSize": 14
                                          })
        property font titleExtraSmall: Qt.font({
                                                   "family": "Rubik",
                                                   "styleName": "Medium",
                                                   "pixelSize": 13
                                               })
        property font titleSmallest: Qt.font({
                                                 "family": "Rubik",
                                                 "styleName": "Medium",
                                                 "pixelSize": 12
                                             })
        property font bodyExtraLarge: Qt.font({
                                                  "family": "Rubik",
                                                  "styleName": "Regular",
                                                  "pixelSize": 16
                                              })
        property font bodyLarge: Qt.font({
                                             "family": "Rubik",
                                             "styleName": "Regular",
                                             "pixelSize": 14
                                         })
        property font bodyMedium: Qt.font({
                                              "family": "Rubik",
                                              "styleName": "Regular",
                                              "pixelSize": 13
                                          })
        property font bodySmall: Qt.font({
                                             "family": "Rubik",
                                             "styleName": "Regular",
                                             "pixelSize": 12
                                         })
        property font bodyExtraSmall: Qt.font({
                                                  "family": "Rubik",
                                                  "styleName": "Regular",
                                                  "pixelSize": 11
                                              })
        property font bodySmallest: Qt.font({
                                                "family": "Rubik",
                                                "styleName": "Regular",
                                                "pixelSize": 10
                                            })
        property font overline: Qt.font({
                                            "family": "Rubik",
                                            "styleName": "Regular",
                                            "pixelSize": 10,
                                            "capitalization": Font.AllUppercase,
                                            "letterSpacing": 0.1
                                        })
        property font buttonLarge: Qt.font({
                                               "family": "Rubik",
                                               "styleName": "Medium",
                                               "pixelSize": 20
                                           })
        property font buttonMedium: Qt.font({
                                                "family": "Rubik",
                                                "styleName": "Medium",
                                                "pixelSize": 15
                                            })
        property font buttonSmall: Qt.font({
                                               "family": "Rubik",
                                               "styleName": "Medium",
                                               "pixelSize": 11
                                           })
    }

    property QtObject buttons: QtObject {
        property QtObject sizes: QtObject {
            property QtObject large: QtObject {
                property real height: 48
                property real radius: 0
                property real horizontalPadding: 20
                property real spacing: 12
                property font textFont: fonts.buttonLarge
                property real iconWidth: 20
                property real iconHeight: 20
            }

            property QtObject medium: QtObject {
                property real height: 32
                property real radius: 0
                property real horizontalPadding: 16
                property real spacing: 8
                property font textFont: fonts.buttonMedium
                property real iconWidth: 16
                property real iconHeight: 16
            }

            property QtObject small: QtObject {
                property real height: 24
                property real radius: 0
                property real horizontalPadding: 10
                property real spacing: 6
                property font textFont: fonts.buttonSmall
                property real iconWidth: 12
                property real iconHeight: 12
            }
        }

        property QtObject colors: QtObject {
            property QtObject accent: QtObject {
                property QtObject normal: QtObject {
                    property color background: colors.accentNormal
                    property color textColor: colors.primary10
                }
                property QtObject hover: QtObject {
                    property color background: colors.accentHover
                    property color textColor: colors.primary10
                }
                property QtObject click: QtObject {
                    property color background: colors.accentClick
                    property color textColor: colors.primary10
                }
            }

            property QtObject secondary: QtObject {
                property QtObject normal: QtObject {
                    property color background: colors.secondaryNormal
                    property color textColor: colors.primary90
                }
                property QtObject hover: QtObject {
                    property color background: colors.secondaryHover
                    property color textColor: colors.primary90
                }
                property QtObject click: QtObject {
                    property color background: colors.secondaryClick
                    property color textColor: colors.primary90
                }
            }

            property QtObject tertiary: QtObject {
                property QtObject normal: QtObject {
                    property color background: colors.tertiaryNormal
                    property color textColor: colors.primary10
                }
                property QtObject hover: QtObject {
                    property color background: colors.tertiaryHover
                    property color textColor: colors.primary10
                }
                property QtObject click: QtObject {
                    property color background: colors.tertiaryClick
                    property color textColor: colors.primary10
                }
            }

            property QtObject danger: QtObject {
                property QtObject normal: QtObject {
                    property color background: colors.dangerNormal
                    property color textColor: colors.primary10
                }
                property QtObject hover: QtObject {
                    property color background: colors.dangerHover
                    property color textColor: colors.primary10
                }
                property QtObject click: QtObject {
                    property color background: colors.dangerClick
                    property color textColor: colors.primary10
                }
            }
        }
    }

    property QtObject textFields: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real height: 32
                property real horizontalPadding: 8
                property font textFont: fonts.bodyLarge
            }

            property QtObject small: QtObject {
                property real height: 24
                property real horizontalPadding: 8
                property font textFont: fonts.bodySmall
            }

            property QtObject extraSmall: QtObject {
                property real height: 21
                property real horizontalPadding: 6
                property font textFont: fonts.bodyExtraSmall
            }
        }

        property QtObject colors: QtObject {
            property QtObject accent: QtObject {
                property QtObject normal: QtObject {
                    property color background: colors.primary90
                    property color textColor: colors.primary20
                    property color border: colors.primary50
                }
                property QtObject hover: QtObject {
                    property color background: colors.primary90
                    property color textColor: colors.primary20
                    property color border: colors.accentNormal
                }
                property QtObject active: QtObject {
                    property color background: colors.primary90
                    property color textColor: colors.primary10
                    property color border: colors.accentHover
                }
                property QtObject warning: QtObject {
                    property color background: colors.primary90
                    property color textColor: colors.primary10
                    property color border: colors.warning
                }
                property QtObject error: QtObject {
                    property color background: colors.primary90
                    property color textColor: colors.primary10
                    property color border: colors.dangerNormal
                }

                property color selection: colors.primary50
                property color selectionText: colors.primary10
            }
        }
    }

    property QtObject checkBoxes: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real iconWidth: 14
                property real iconHeight: 14
                property string iconAsset: "MediumCheckbox"
                property real spacing: 8
                property font textFont: fonts.bodyLarge
            }

            property QtObject small: QtObject {
                property real iconWidth: 12
                property real iconHeight: 12
                property string iconAsset: "SmallCheckbox"
                property real spacing: 8
                property font textFont: fonts.bodySmall
            }
        }
    }

    property QtObject radioButtons: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real iconWidth: 14
                property real iconHeight: 14
                property string iconAsset: "MediumRadio"
                property real spacing: 8
                property font textFont: fonts.bodyLarge
            }

            property QtObject small: QtObject {
                property real iconWidth: 12
                property real iconHeight: 12
                property string iconAsset: "SmallRadio"
                property real spacing: 8
                property font textFont: fonts.bodySmall
            }
        }
    }

    property QtObject comboBoxes: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real height: 32
                property real indicatorWidth: 32
                property real indicatorImageWidth: 16
                property real indicatorImageHeight: 16
                property real maxDropDownHeight: 160
                property string indicatorAsset: "DownArrow"
                property QtObject textField: textFields.sizes.medium
            }

            property QtObject small: QtObject {
                property real height: 24
                property real indicatorWidth: 24
                property real indicatorImageWidth: 16
                property real indicatorImageHeight: 16
                property real maxDropDownHeight: 120
                property string indicatorAsset: "DownArrow"
                property QtObject textField: textFields.sizes.small
            }
        }

        property QtObject colors: QtObject {
            property QtObject accent: QtObject {
                property QtObject normal: QtObject {
                    property color background: colors.primary90
                    property color border: colors.primary50
                }
                property QtObject hover: QtObject {
                    property color background: colors.primary90
                    property color border: colors.accentNormal
                }

                property color dropDownSelection: colors.primary100
                property color dropDownHighlight: colors.primary70
                property QtObject textField: textFields.colors.accent
            }
        }
    }

    property QtObject imageLabels: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real imageWidth: 16
                property real imageHeight: 16
                property font textFont: fonts.bodyMedium
                property real spacing: 8
            }

            property QtObject large: QtObject {
                property real imageWidth: 16
                property real imageHeight: 16
                property font textFont: fonts.bodyLarge
                property real spacing: 10
            }
        }
    }

    property QtObject sliders: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real handleWidth: 20
                property real handleHeight: 20
                property real sliderHeight: 2
                property font rangeValueFont: fonts.bodySmall
                property font selectedValueFont: fonts.bodyLarge
                property font recommendedValueFont: fonts.bodySmall
            }

            property QtObject small: QtObject {
                property real handleWidth: 16
                property real handleHeight: 16
                property real sliderHeight: 2
                property font rangeValueFont: fonts.bodyExtraSmall
                property font selectedValueFont: fonts.bodySmall
                property font recommendedValueFont: fonts.bodyExtraSmall
            }
        }

        property QtObject colors: QtObject {
            property QtObject accent: QtObject {
                property color handleBackground: colors.accentNormal
                property color handleBackgroundDisabled: colors.primary30
                property color handleBorder: colors.primary80
                property color sliderBackground: colors.primary20
                property color sliderBackgroundDisabled: colors.primary50
                property color sliderFill: colors.accentNormal
                property color sliderFillDisabled: colors.primary40
                property color rangeValue: colors.primary20
                property color selectedValue: colors.primary10
                property color recommendedValue: colors.primary30
            }
        }
    }

    property QtObject toggleButtons: QtObject {
        property QtObject sizes: QtObject {
            property QtObject medium: QtObject {
                property real iconWidth: 28
                property real iconHeight: 14
                property string iconAsset: "MediumToggle"
                property real spacing: 8
                property font textFont: fonts.bodyMedium
            }

            property QtObject small: QtObject {
                property real iconWidth: 24
                property real iconHeight: 12
                property string iconAsset: "SmallToggle"
                property real spacing: 8
                property font textFont: fonts.bodySmall
            }
        }
    }

    property QtObject progressBars: QtObject {
        property QtObject normal: QtObject {
            property color foreground: colors.accentNormal
            property color background: colors.overLayTint
        }
    }

    property QtObject textImageField: QtObject {
        property QtObject normal: QtObject {
            property color borderColor: colors.accentNormal
            property int imageWidth: 12
            property int imageHeight: 12
            property int rightPadding: 4
            property int borderWidth: 1
        }
    }

    property QtObject dialogs: QtObject {
        property QtObject sizes: QtObject {
            property QtObject simpleNarrow: QtObject {
                property real width: 320
                property real padding: 16
                property real headerHorizontalSpacing: 8
                property real headerVerticalSpacing: 0
                property real contentTopMargin: 16
                property real contentBottomMargin: 20
                property real contentVerticalSpacing: 8
                property real contentHorizontalSpacing: 0
                property real footerHorizontalSpacing: 16
                property real footerVerticalSpacing: 16
                property font titleFont: fonts.titleMedium
                property font subtitleFont: fonts.bodyExtraLarge
                property font descriptionFont: fonts.bodyLarge
                property font noticeFont: fonts.bodyLarge
                property real iconWidth: 20
                property real iconHeight: 20
            }

            property QtObject simple: QtObject {
                property real width: 360
                property real padding: 16
                property real headerHorizontalSpacing: 8
                property real headerVerticalSpacing: 0
                property real contentTopMargin: 16
                property real contentBottomMargin: 20
                property real contentVerticalSpacing: 8
                property real contentHorizontalSpacing: 0
                property real footerHorizontalSpacing: 16
                property real footerVerticalSpacing: 16
                property font titleFont: fonts.titleMedium
                property font subtitleFont: fonts.bodyExtraLarge
                property font descriptionFont: fonts.bodyLarge
                property font noticeFont: fonts.bodyLarge
                property real iconWidth: 20
                property real iconHeight: 20
            }

            property QtObject descriptive: QtObject {
                property real width: 440
                property real padding: 16
                property real headerHorizontalSpacing: 8
                property real headerVerticalSpacing: 0
                property real contentTopMargin: 16
                property real contentBottomMargin: 20
                property real contentVerticalSpacing: 8
                property real contentHorizontalSpacing: 16
                property real footerHorizontalSpacing: 16
                property real footerVerticalSpacing: 16
                property font titleFont: fonts.titleMedium
                property font subtitleFont: fonts.bodyExtraLarge
                property font descriptionFont: fonts.bodyLarge
                property font noticeFont: fonts.bodyLarge
                property real iconWidth: 72
                property real iconHeight: 72
            }

            property QtObject tall: QtObject {
                property real width: 320
                property real padding: 20
                property real headerHorizontalSpacing: 0
                property real headerVerticalSpacing: 0
                property real contentTopMargin: 20
                property real contentBottomMargin: 20
                property real contentVerticalSpacing: 8
                property real contentHorizontalSpacing: 0
                property real footerHorizontalSpacing: 0
                property real footerVerticalSpacing: 16
                property font titleFont: fonts.titleMedium
                property font subtitleFont: fonts.bodyExtraLarge
                property font descriptionFont: fonts.bodyLarge
                property font noticeFont: fonts.bodyLarge
                property real iconWidth: 96
                property real iconHeight: 96
            }
        }

        property QtObject colors: QtObject {
            property QtObject accent: QtObject {
                property color background: colors.primary70
                property color border: colors.primary60
                property color title: colors.primary10
                property color subtitle: colors.primary10
                property color description: colors.primary20
                property color notice: colors.warning
            }
        }
    }
}
