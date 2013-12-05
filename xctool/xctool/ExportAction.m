//
//  ExportAction.m
//  xctool
//
//  Created by John Foulkes on 05/12/2013.
//  Copyright (c) 2013 Facebook, Inc. All rights reserved.
//

#import "ExportAction.h"

#import "Options.h"
#import "XCToolUtil.h"

@interface ExportAction()

@property (nonatomic, retain) NSString *exportPath;
@property (nonatomic, retain) NSString *exportFormat;

@end

@implementation ExportAction

+ (NSString *)name
{
  return @"export";
}

- (BOOL)performActionWithOptions:(Options *)options xcodeSubjectInfo:(XcodeSubjectInfo *)xcodeSubjectInfo
{
  NSMutableArray *arguments = [[options xcodeBuildArgumentsForSubject] mutableCopy];
  [arguments addObjectsFromArray: [options commonXcodeBuildArgumentsForSchemeAction: @"ExportAction"
                                                                   xcodeSubjectInfo: xcodeSubjectInfo]];
  [arguments addObject: @"export"];
  
  if (_exportPath) {
    [arguments addObjectsFromArray:@[@"-exportPath", _exportPath]];
  }
  
  if (_exportFormat) {
    [arguments addObjectsFromArray:@[@"-exportFormat", _exportFormat]];
  }
  
  return RunXcodebuildAndFeedEventsToReporters(arguments,
                                               @"export",
                                               [options scheme],
                                               [options reporters]);
}

+ (NSArray *)options
{
  return
  @[
    [Action actionOptionWithName: @"exportFormat"
                         aliases: nil
                     description: @"Export format of archive"
                       paramName: @"EXPORTFORMAT"
                           mapTo: @selector(setExportFormat:)],
    [Action actionOptionWithName: @"exportPath"
                         aliases: nil
                     description: @"PATH where export will be created"
                       paramName: @"EXPORTPATH"
                           mapTo: @selector(setExportPath:)]
    ];
}

- (void) dealloc
{
  _exportFormat = nil;
  _exportPath = nil;
  [super dealloc];
}

@end