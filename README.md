# Lessons


#  SwiftUI

[Native Popovers for iOS SwiftUI - Xcode 14 - SwiftUI Tutorials](https://github.com/VladimirFibe/Lessons/tree/main/Targets/Lessons/Sources/Lessons/PopOvers)

mkdir Lessons
cd Lessons 
tuist init --platform ios --template swiftui
tuist edit
tuist generate -n
git init
git status
git add .
git commit -m "Start"
curl -u "VladimirFibe" https://api.github.com/user/repos -d '{"name":"Lessons"}' 
git remote add origin https://github.com/VladimirFibe/Lessons.git
git push
git push --set-upstream origin main
nano README.md
