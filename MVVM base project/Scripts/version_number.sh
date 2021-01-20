#!/bin/sh

#  version_number.sh
#  GoPlant.me
#
#  Created by Ljubo Maricevic on 11/07/2019.
#  Copyright © 2019 Ljubo Maricevic. All rights reserved.

buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$INFOPLIST_FILE")
buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$INFOPLIST_FILE"
