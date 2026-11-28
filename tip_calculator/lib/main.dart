
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const TipApp());
}

// Main application widget
class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const TipPage(),
    );
  }
}

// Converts the bill input into a number.
// Returns null if the input is invalid.
double? parseBill(String input) {
  return double.tryParse(input.trim());
}

// Calculates the tip and total using a record.
({double tip, double total}) computeTip(
  double bill,
  int percent,
) {
  final tip = bill * percent / 100;

  return (
    tip: tip,
    total: bill + tip,
  );
}

// Tip calculator screen
class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  // Controller for the bill amount input
  final TextEditingController _billController =
      TextEditingController();

  // Default selected tip percentage
  // This value is retained while the app is open.
  int _selectedPercent = 15;

  // Number of people sharing the bill
  int _peopleCount = 1;

  // Releases the controller when the screen is removed
  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Read and validate the bill amount
    final bill = parseBill(_billController.text);

    // Calculate the tip and total if input is valid
    final result = bill != null && bill > 0
        ? computeTip(bill, _selectedPercent)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.calculate_rounded,
              size: 80,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 16),

            const Text(
              'Calculate Your Tip',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Enter your bill and select a tip percentage.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Bill amount input
            const Text(
              'Bill Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _billController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixText: '₱ ',
                hintText: 'Enter bill amount',
                prefixIcon: Icon(Icons.payments),
              ),

              // Update calculation whenever input changes
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 28),

            // Tip percentage selection
            const Text(
              'Select Tip Percentage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 8,
              children: [10, 15, 20].map((percent) {
                return ChoiceChip(
                  label: Text('$percent%'),
                  selected: _selectedPercent == percent,
                  onSelected: (selected) {
                    setState(() {
                      _selectedPercent = percent;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            // Split bill stepper
            const Text(
              'Split Between People',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Number of People',
                      style: TextStyle(fontSize: 15),
                    ),

                    Row(
                      children: [
                        // Decrease number of people
                        IconButton(
                          onPressed: _peopleCount > 1
                              ? () {
                                  setState(() {
                                    _peopleCount--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),

                        Text(
                          '$_peopleCount',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Increase number of people
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _peopleCount++;
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Calculation results
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Calculation Summary',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Show results or validation message
                    if (result == null) ...[
                      const Icon(
                        Icons.info_outline,
                        size: 35,
                        color: Colors.orange,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Enter a valid amount',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ] else ...[
                      _resultRow(
                        'Tip ($_selectedPercent%)',
                        '₱${result.tip.toStringAsFixed(2)}',
                      ),

                      const SizedBox(height: 12),

                      _resultRow(
                        'Total Amount',
                        '₱${result.total.toStringAsFixed(2)}',
                        isTotal: true,
                      ),

                      const Divider(height: 28),

                      // Amount each person should pay
                      _resultRow(
                        'Per Person ($_peopleCount people)',
                        '₱${(result.total / _peopleCount).toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Reset bill and people count.
            // Keep the last selected tip percentage.
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _billController.clear();
                  _peopleCount = 1;
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Calculator'),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable widget for displaying calculation results
  Widget _resultRow(
    String label,
    String amount, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),

        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 20 : 17,
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.deepPurple : null,
          ),
        ),
      ],
    );
  }
}
