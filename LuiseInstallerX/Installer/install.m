//
//  install.m
//  LuiseInstallerX
//
//  Created by Alfie on 22/03/2024.
//

#import <Foundation/Foundation.h>

#import <spawn.h>
#import <sys/stat.h>

#import "run.h"

// Install LuiseStore
bool install_luisestore(NSString *tar) {
    NSString *stdout;
    NSString *helperPath = @"/private/preboot/tmp/luisestorehelper";
    chmod(helperPath.UTF8String, 0755);
    chown(helperPath.UTF8String, 0, 0);
    int ret = run_binary(helperPath, @[@"install-luisestore", tar], &stdout);
    printf("luisestorehelper output: %s\n", [stdout UTF8String]);
    return ret == 0;
}

NSString *find_path_for_app(NSString *appName) {
    // Go through /var/containers/Bundle/Application
    // Look inside every folder for @appName.app
    // If we get a match, return $PATH_TO_APP/@appName

    // Hacky, but it works
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *bundlePath = @"/var/containers/Bundle/Application";
    NSArray *bundleContents = [fileManager contentsOfDirectoryAtPath:bundlePath error:nil];

    for (NSString *bundle in bundleContents) {
        NSString *bundleFullPath = [bundlePath stringByAppendingPathComponent:bundle];
        NSString *bundleFullPathWithApp = [bundleFullPath stringByAppendingPathComponent:appName];
        NSString *appPath = [bundleFullPathWithApp stringByAppendingString:@".app"];
        if ([fileManager fileExistsAtPath:appPath]) {
            return appPath;
        }
    }
    
    return nil;
}

bool install_persistence_helper(NSString *app) {
    NSString *stdout;
    NSString *helperPath = @"/private/preboot/tmp/luisestorehelper";
    NSString *persistenceHelperPath = @"/private/preboot/tmp/LuiseStore/LuiseStore.app/PersistenceHelper";
    int ret = run_binary(helperPath, @[@"install-persistence-helper", app, persistenceHelperPath, helperPath], &stdout);
    printf("luisestorehelper returned %d\n", ret);
    printf("luisestorehelper output: %s\n", [stdout UTF8String]);
    return ret == 0;
}
