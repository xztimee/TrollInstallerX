//
//  install.h
//  LuiseInstallerX
//
//  Created by Alfie on 22/03/2024.
//

#ifndef install_h
#define install_h

NSString *find_path_for_app(NSString *appName);
bool install_luisestore(NSString *tar);
bool install_persistence_helper(NSString *app);

#endif /* install_h */
