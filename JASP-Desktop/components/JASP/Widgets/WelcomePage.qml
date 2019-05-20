//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick			2.11
import QtQuick.Controls 2.4
import JASP.Theme		1.0
import JASP.Widgets		1.0

FocusScope
{
	FontLoader { id: latoLightFontFamily;	source: "qrc:/core/font/Lato-Light.ttf" }
	FontLoader { id: latoRegularFontFamily;	source: "qrc:/core/font/Lato-Regular.ttf" }

	id:		welcomeRoot

	property real scaler: 0.9

	Rectangle
	{
		id:					centerPiece
		color:				"white"
		height:				400 * welcomeRoot.scaler
		anchors
		{
			verticalCenter:	parent.verticalCenter
			left:			parent.left
			right:			parent.right
		}

		Item
		{
			id:					info
			z:					1
			anchors.centerIn:	parent
			height:				550 * welcomeRoot.scaler
			width:				700 * welcomeRoot.scaler

			Image
			{
				id:				jaspLogo
				source:			"qrc:/core/img/jasp-logo.svg"
				width:			(190 / 40) * height
				height:			info.height / 14
				mipmap:			true
				sourceSize
				{
					width:		jaspLogo.width  * 2
					height:		jaspLogo.height * 2
				}

				anchors
				{
					top:		parent.top
					left:		parent.left
				}
			}

			Text
			{
				id:				welcomeToJASP
				text:			qsTr("Welcome to JASP")
				color:			"white"
				font.family:	latoRegularFontFamily.name
				font.pixelSize: 30 * welcomeRoot.scaler

				anchors
				{
					top:				jaspLogo.bottom
					horizontalCenter:	parent.horizontalCenter
				}
			}

			Rectangle
			{
				id:			jaspRuler
				color:		"white"
				opacity:	0.5
				height:		4 * welcomeRoot.scaler
				anchors
				{
					top:		welcomeToJASP.bottom
					left:		parent.left
					right:		parent.right
					topMargin:	Theme.generalAnchorMargin
				}
			}

			Text
			{
				id:				freshAndFunky
				text:			qsTr("A Fresh Way to Do Statistics: Free, Friendly, and Flexible")
				color:			"white"
				font.family:	latoLightFontFamily.name
				font.pixelSize: 16 * welcomeRoot.scaler

				anchors
				{
					top:				jaspRuler.bottom
					topMargin:			jaspRuler.anchors.topMargin
					horizontalCenter:	parent.horizontalCenter
				}
			}

			ListModel
			{
				id: bitingTheBullets

				ListElement { keyword: qsTr("Free:");		explanation: qsTr("JASP is an open-source project with structural support from the University of Amsterdam.");		}
				ListElement { keyword: qsTr("Friendly:");	explanation: qsTr("JASP has an intuitive interface that was designed with the user in mind.");						}
				ListElement { keyword: qsTr("Flexible:");	explanation: qsTr("JASP offers standard analysis procedures in both their classical and Bayesian manifestations.");	}
			}

			Component
			{
				id: bulletPointComp

				Item
				{
					width:					parent.width
					height:					Math.max(blueKeyword.height, explanationElement.height)

					Image
					{
						id:					orangeDot
						source:				"qrc:/core/img/ul-orange-dot.png"
						width:				height
						height:				8 * welcomeRoot.scaler
						mipmap:				true

						anchors
						{
							verticalCenter:	parent.verticalCenter
							left:			parent.left
							margins:		1 //welcomeRoot.scaler
						}
					}

					TextArea
					{
						id:					blueKeyword
						text:				keyword
						font.family:		latoRegularFontFamily.name
						font.pixelSize:		explanationElement.font.pixelSize
						font.bold:			true
						verticalAlignment:	Text.AlignVCenter
						color:				"#23a1df"
						width:				80 * welcomeRoot.scaler
						readOnly:			true
						selectByKeyboard:	false
						selectByMouse:		false
						anchors
						{
							verticalCenter:	orangeDot.verticalCenter
							left:			orangeDot.right
							margins:		orangeDot.anchors.margins
						}
					}

					TextArea
					{
						id:					explanationElement
						text:				explanation
						font.family:		latoLightFontFamily.name
						font.pixelSize:		freshAndFunky.font.pixelSize
						verticalAlignment:	Text.AlignVCenter
						color:				"black"
						wrapMode:			TextEdit.Wrap
						readOnly:			true
						selectByKeyboard:	false
						selectByMouse:		false
						anchors
						{
							verticalCenter:	blueKeyword.verticalCenter
							left:			blueKeyword.right
							right:			parent.right
						}
					}
				}
			}

			Column
			{
				id:							bulletPoints
				width:						parent.widthOverflowers
				height:						childrenRect.height
				spacing:					2 //* preferencesModel.uiScale
				anchors.horizontalCenter:	parent.horizontalCenter
				y:							(parent.height / 2) - (height / 2) - 10

				Repeater
				{
					model:				bitingTheBullets
					delegate:			bulletPointComp

				}
			}

			Text
			{
				id:						openADataFile
				text:					qsTr("So open a data file and take JASP for a spin!")
				font.underline:			openDataFileMouse.containsMouse
				font.family:			latoRegularFontFamily.name
				font.pixelSize:			freshAndFunky.font.pixelSize + 2

				anchors
				{
					horizontalCenter:	parent.horizontalCenter
					top:				bulletPoints.bottom
					topMargin:			20
				}

				MouseArea
				{
					id:				openDataFileMouse
					anchors.fill:	parent
					hoverEnabled:	true
					onClicked:		fileMenuModel.showFileOpenMenu()
					cursorShape:	Qt.PointingHandCursor
				}

			}

			property int widthOverflowers:	width * 0.9

			TextArea
			{
				id:					keepInMindBeta
				text:				qsTr("Please keep in mind that this is a preview release and a number of features are still missing.\n\nIf JASP doesn’t do all you want today, then check back tomorrow: JASP is being developed at break-neck speed!")
				font:				freshAndFunky.font
				color:				"white"
				width:				parent.widthOverflowers
				wrapMode:			TextEdit.Wrap
				readOnly:			true
				selectByKeyboard:	false
				selectByMouse:		false

				anchors
				{
					bottom:				parent.bottom
					bottomMargin:		-20
					horizontalCenter:	parent.horizontalCenter
				}
			}
		}


		Image
		{
			id:					blueWave
			fillMode:			Image.TileHorizontally
			height:				100  * welcomeRoot.scaler
			sourceSize.width:	1400 * welcomeRoot.scaler
			sourceSize.height:	height
			source:				"qrc:/core/img/jasp-wave-down-blue-120.svg"
			anchors
			{
				top:			parent.top
				left:			parent.left
				right:			parent.right

			}
		}

		Image
		{
			id:					greenWave
			fillMode:			blueWave.fillMode
			height:				blueWave.height
			sourceSize.width:	blueWave.sourceSize.width
			sourceSize.height:	blueWave.sourceSize.height
			source:				"qrc:/core/img/jasp-wave-up-green-120.svg"
			anchors
			{
				left:			parent.left
				right:			parent.right
				bottom:			parent.bottom

			}
		}
	}

	Rectangle
	{
		id:			blueBackgroundTop
		z:			-1
		color:		"#14a1e3"
		anchors
		{
			top:	parent.top
			left:	parent.left
			right:	parent.right
			bottom:	parent.verticalCenter
		}
	}

	Rectangle
	{
		id:			greenBackgroundTop
		z:			-1
		color:		"#8cc63e"
		anchors
		{
			top:	parent.verticalCenter
			left:	parent.left
			right:	parent.right
			bottom:	parent.bottom
		}
	}
}