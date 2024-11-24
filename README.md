### Steps to Run the App
1. Open "Fetch Recipes.xcodeproj" in Xcode
2. Run the app on the simulator, or change the bundleID, select a team, and run on a device.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
Performance was a high priority. I used not just an on-device cache, but also cached the images in memory. iOS  users have high expectations on things like 
scrolling performance, so tuning things like image caching is important.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent about 5 hours on this project. First, I got a rough version of the UI working. Next I implemented image caching. Then I spent some time polishing the 
user interface. Finally, I wrote unit and XCUI tests.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I don't think so.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The user interface is pretty bare-bones. Normally, I would work closely with the UX team to do things like apply branding in order to make the app stand out.

With more time, I would also have done accessibility testing.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No external code was used.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
