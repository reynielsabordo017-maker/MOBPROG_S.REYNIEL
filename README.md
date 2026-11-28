
# Hello Flutter: Tip Calculator

Developer: Reyniel M. Sabordo

A simple Flutter application that calculates tips and total bill amounts using selectable percentages of 10%, 15%, and 20%.

## Features

- Enter a bill amount.
- Select a tip percentage (10%, 15%, or 20%).
- Automatically calculate the tip and total amount.
- Validate invalid bill inputs.
- Display currency values with two decimal places.
- Reset the calculator.

## Technologies Used

- Flutter
- Dart
- Material 3
- Visual Studio Code

## Application Screenshot

![Tip Calculator Application](screenshots/tip-calculator.png)

![Tip Calculator Application](screenshots/tip1-calculator.png)

![Tip Calculator Application](screenshots/tip2-calculator.png)

## How to Run

1. Clone this repository.
2. Open the project folder in VS Code.
3. Run `flutter pub get`.
4. Run `flutter run -d chrome`.

## Testing

Run the following commands:

```bash
flutter analyze
flutter test
```

## Extension Challenge

Split between N people:

![Tip Calculator Application](screenshots/tip3-calculator.png)

Reflection Questions:

Why does the tip calculator need a StatefulWidget rather than a StatelessWidget?

The tip calculator needs a StatefulWidget because the values change when the user enters a bill amount, selects a tip percentage, or adjusts the number of people. It allows the application to update its interface whenever the user changes these values.

What is the difference between a hot reload and a hot restart, and when did you need each today?

Hot reload applies code changes without restarting the entire application and usually keeps the current state. Hot restart restarts the application and resets its current state. I used hot reload when updating the interface and hot restart when I needed to restart the application to apply changes.

What would happen if you used double.parse instead of double.tryParse for the bill?

Using double.parse with invalid input, such as letters or an empty value, can cause a FormatException. On the other hand, double.tryParse returns null when the input is invalid, allowing the application to handle errors without crashing.
