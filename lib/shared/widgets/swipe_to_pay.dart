import 'package:barq_recharge/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SwipeToPay extends StatefulWidget {
  const SwipeToPay({
    super.key,
    required this.label,
    required this.onCompleted,
    this.enabled = true,
    this.processing = false,
  });

  final String label;
  final VoidCallback onCompleted;
  final bool enabled;
  final bool processing;

  @override
  State<SwipeToPay> createState() => _SwipeToPayState();
}

class _SwipeToPayState extends State<SwipeToPay> {
  double _dragProgress = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final knobSize = 56.0;
        final maxDrag = constraints.maxWidth - knobSize - 8;
        final left = 4 + (_dragProgress * maxDrag);

        return Container(
          height: 64,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [AppColors.foreground, AppColors.darkCard],
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Text(
                  widget.processing ? 'جاري التنفيذ...' : widget.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              Positioned(
                left: left,
                child: GestureDetector(
                  onHorizontalDragUpdate: (!widget.enabled || widget.processing)
                      ? null
                      : (details) {
                          setState(() {
                            _dragProgress =
                                (_dragProgress + (details.delta.dx / maxDrag))
                                    .clamp(0, 1);
                          });
                        },
                  onHorizontalDragEnd: (!widget.enabled || widget.processing)
                      ? null
                      : (_) {
                          if (_dragProgress > 0.88) {
                            setState(() {
                              _dragProgress = 1;
                            });
                            widget.onCompleted();
                          } else {
                            setState(() {
                              _dragProgress = 0;
                            });
                          }
                        },
                  child: Container(
                    width: knobSize,
                    height: knobSize,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Color(0xFFE9EEF5)],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 14,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.processing
                          ? Icons.hourglass_top_rounded
                          : Icons.arrow_forward_rounded,
                      color: AppColors.foreground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
