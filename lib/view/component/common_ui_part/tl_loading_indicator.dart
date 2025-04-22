import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';

class TLLoadingIndicator extends StatelessWidget {
  const TLLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TLTheme.of(context);

    return Center(child: CircularProgressIndicator(color: theme.accentColor));
  }
}

class TLErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const TLErrorWidget({super.key, this.message = 'エラーが発生しました', this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = TLTheme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: theme.accentColor, size: 48),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.accentColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('再試行'),
            ),
          ],
        ],
      ),
    );
  }
}
