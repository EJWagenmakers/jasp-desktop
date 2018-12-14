import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import JASP.Theme 1.0

Rectangle
{
	id:rect
	objectName: "rect"
	color:		Theme.grayMuchLighter
	
	Label
	{
		id:				headlabel

		height:			30
		anchors
		{
			top:		parent.top
			left:		parent.left  //Position Datalibrary label
			right:		parent.right
			leftMargin: 12
			topMargin:	12
		}

		text:	"Data Library"
		font:	Theme.fontLabel
	}
	
	BreadCrumbs
	{
		id:				datalibrarybreadcrumbs
		
		model :			fileMenuModel.datalibrary.breadcrumbsmodel
		
		width:			rect.width
		height:			40
		anchors
		{
			top:		headlabel.bottom
			left:		parent.left
			right:		parent.right
			leftMargin:	12  //Position datalibrary breadcrumbs
		}

		onCrumbButtonClicked: model.indexChanged(modelIndex)
	}
	
	ToolSeparator
	{
		id:				secondseparator
		anchors.top:	datalibrarybreadcrumbs.bottom
		width:			rect.width
		orientation:	Qt.Horizontal
	}
	
	DataLibraryList
	{
		id: datalibrarylist

		anchors
		{
			top:			secondseparator.bottom
			bottom:			parent.bottom
			left:			parent.left
			right:			parent.right
			leftMargin:		12  //Position datalibrary items
			topMargin:		Theme.generalAnchorMargin
			bottomMargin:	Theme.generalAnchorMargin
			rightMargin:	Theme.generalAnchorMargin
		}
	}
}

