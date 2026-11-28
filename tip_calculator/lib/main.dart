
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

      // Material 3 theme
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
  int _selectedPercent = 15;

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

              // Update the calculation whenever input changes
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

                  // Update the selected percentage
                  onSelected: (selected) {
                    setState(() {
                      _selectedPercent = percent;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

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

                    // Show tip and total or validation message
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

                      const Divider(height: 28),

                      _resultRow(
                        'Total Amount',
                        '₱${result.total.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Reset the calculator
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _billController.clear();
                  _selectedPercent = 15;
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
