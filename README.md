# Lessons


fibe@Vladimirs-MacBook-Air Developer % mkdir Lessons
fibe@Vladimirs-MacBook-Air Developer % cd Lessons 
fibe@Vladimirs-MacBook-Air Lessons % tuist init --platform ios --template swiftui
fibe@Vladimirs-MacBook-Air Lessons % tuist edit
fibe@Vladimirs-MacBook-Air Lessons % tuist generate -n
fibe@Vladimirs-MacBook-Air Lessons % git init
fibe@Vladimirs-MacBook-Air Lessons % git status
fibe@Vladimirs-MacBook-Air Lessons % git add .
fibe@Vladimirs-MacBook-Air Lessons % git commit -m "Start"
fibe@Vladimirs-MacBook-Air Lessons % curl -u "VladimirFibe" https://api.github.com/user/repos -d '{"name":"Lessons"}' 
fibe@Vladimirs-MacBook-Air Lessons % git remote add origin https://github.com/VladimirFibe/Lessons.git
fibe@Vladimirs-MacBook-Air Lessonshub.com/VladimirFibe/Lessons.git


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
