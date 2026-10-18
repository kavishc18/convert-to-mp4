import plistlib, uuid, os, shutil
d = os.path.dirname(os.path.abspath(__file__))
script = open(os.path.join(d, "convert.sh")).read()
wf = os.path.join(d, "Convert to MP4.workflow"); root = os.path.join(wf, "Contents")
shutil.rmtree(wf, ignore_errors=True); os.makedirs(root)
u = lambda: str(uuid.uuid4()).upper()
action = {"action": {
  "AMAccepts": {"Container": "List", "Optional": True, "Types": ["com.apple.cocoa.string"]},
  "AMActionVersion": "2.0.3", "AMApplication": ["Automator"],
  "AMParameterProperties": {k: {} for k in ["COMMAND_STRING","CheckedForUserDefaultShell","inputMethod","shell","source"]},
  "AMProvides": {"Container": "List", "Types": ["com.apple.cocoa.string"]},
  "ActionBundlePath": "/System/Library/Automator/Run Shell Script.action",
  "ActionName": "Run Shell Script",
  "ActionParameters": {"COMMAND_STRING": script, "CheckedForUserDefaultShell": True, "inputMethod": 1, "shell": "/bin/bash", "source": ""},
  "BundleIdentifier": "com.apple.RunShellScript", "CFBundleVersion": "2.0.3",
  "CanShowSelectedItemsWhenRun": False, "CanShowWhenRun": True,
  "Category": ["AMCategoryUtilities"], "Class Name": "RunShellScriptAction",
  "InputUUID": u(), "Keywords": ["Shell","Script","Command","Run","Unix"],
  "OutputUUID": u(), "UUID": u(), "UnlocalizedApplications": ["Automator"],
  "arguments": {}, "isViewVisible": True}}
wflow = {"AMApplicationBuild": "523", "AMApplicationVersion": "2.10", "AMDocumentVersion": "2",
  "actions": [action], "connectors": {},
  "workflowMetaData": {"serviceInputTypeIdentifier": "com.apple.Automator.fileSystemObject",
    "serviceOutputTypeIdentifier": "com.apple.Automator.nothing", "serviceProcessesInput": 0,
    "workflowTypeIdentifier": "com.apple.Automator.servicesMenu"}}
info = {"CFBundleName": "Convert to MP4", "NSServices": [{
  "NSMenuItem": {"default": "Convert to MP4"}, "NSMessage": "runWorkflowAsService",
  "NSRequiredContext": {"NSApplicationIdentifier": "com.apple.finder"},
  "NSSendFileTypes": ["public.movie"]}]}
plistlib.dump(wflow, open(os.path.join(root, "document.wflow"), "wb"))
plistlib.dump(info, open(os.path.join(root, "Info.plist"), "wb"))
