from maya.OpenMaya import *
from maya.OpenMayaMPx import *

nodeId = MTypeId(0x00137241) # see mytona_mtypeids.h

class ParamFromLength(MPxNode):
    inputCurve = MObject()
    length = MObject()
    outParam = MObject()

    def compute(self, plug, dataBlock):
        if plug == self.outParam:
            inputCurve = dataBlock.inputValue(ParamFromLength.inputCurve).asNurbsCurve()
            length = dataBlock.inputValue(ParamFromLength.length).asDouble()

            if inputCurve.isNull():
                return

            outParam = dataBlock.outputValue(ParamFromLength.outParam)

            curveFn = MFnNurbsCurve(inputCurve)
            startParam = doublePtr()
            endParam = doublePtr()
            curveFn.getKnotDomain(startParam, endParam)

            if length > curveFn.length():
                outParam.setDouble(endParam.value())
            elif length < 0:
                outParam.setDouble(startParam.value())
            else:
                outParam.setDouble(curveFn.findParamFromLength(length))

            dataBlock.setClean(plug)

def ParamFromLengthCreator():
    return asMPxPtr( ParamFromLength() )

def ParamFromLengthInit():
    attr = MFnTypedAttribute()
    ParamFromLength.inputCurve = attr.create("inputCurve", "inputCurve", MFnData.kNurbsCurve)
    attr.setHidden(True)

    attr = MFnNumericAttribute()
    ParamFromLength.length = attr.create("length", "length", MFnNumericData.kDouble, 0)
    attr.setMin(0)
    attr.setKeyable(True)

    ParamFromLength.outParam = attr.create("outParam", "outParam", MFnNumericData.kDouble, 0)

    ParamFromLength.addAttribute(ParamFromLength.inputCurve)
    ParamFromLength.addAttribute(ParamFromLength.length)
    ParamFromLength.addAttribute(ParamFromLength.outParam)

    ParamFromLength.attributeAffects(ParamFromLength.inputCurve, ParamFromLength.outParam)
    ParamFromLength.attributeAffects(ParamFromLength.length, ParamFromLength.outParam)

def initializePlugin(obj):
    plugin = MFnPlugin(obj)
    plugin.registerNode("paramFromLength", nodeId, ParamFromLengthCreator, ParamFromLengthInit)

def uninitializePlugin(obj):
    plugin = MFnPlugin(obj)
    plugin.deregisterNode(nodeId)
