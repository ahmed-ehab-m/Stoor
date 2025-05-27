import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class GeminiListViewItem extends StatefulWidget {
  const GeminiListViewItem({super.key, this.bookModel});
  final BookModel? bookModel;

  @override
  State<GeminiListViewItem> createState() => _GeminiListViewItemState();
}

class _GeminiListViewItemState extends State<GeminiListViewItem>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA855F7),
                      Color(0xFF3B82F6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFA855F7).withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  HugeIcons.strokeRoundedStars,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              SizedBox(width: 12),

              // Chat Bubble
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Name & Time
                    Row(
                      children: [
                        Text(
                          'BookBot AI',
                          style: TextStyle(
                            color: Color(0xFFA855F7),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'now',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    // Chat Message Container
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(
                          AppRouter.KBookDetailsView,
                          extra: widget.bookModel,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E2E).withOpacity(0.8),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(4),
                          ),
                          border: Border.all(
                            color: Color(0xFFA855F7).withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Message Text
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '📚 I found a great book for you!\n\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: '📖 Title: ',
                                    style: TextStyle(
                                      color: Color(0xFFA855F7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${widget.bookModel?.volumeInfo.title ?? 'Unknown Title'}\n\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: '✍️ Author: ',
                                    style: TextStyle(
                                      color: Color(0xFF3B82F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${widget.bookModel?.volumeInfo.authors?.first ?? 'Unknown Author'}\n\n',
                                  ),
                                  TextSpan(
                                    text: '💰 Price: ',
                                    style: TextStyle(
                                      color: Color(0xFF10B981),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'FREE ✨\n\n',
                                    style: TextStyle(
                                      color: Color(0xFF10B981),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (widget
                                          .bookModel?.volumeInfo.description !=
                                      null) ...[
                                    TextSpan(
                                      text: '📝 About: ',
                                      style: TextStyle(
                                        color: Color(0xFFEAB308),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${_getShortDescription(widget.bookModel!.volumeInfo.description!)}\n\n',
                                      style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                  TextSpan(
                                    text: '⭐ Rating: ',
                                    style: TextStyle(
                                      color: Color(0xFFF59E0B),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Not rated',
                                  ),
                                  TextSpan(
                                    text: '5 reviews)',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),

                            // Book Cover & Action Button
                            Row(
                              children: [
                                // Book Cover
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      width: 60,
                                      height: 80,
                                      child: NewestBookImage(
                                        imageUrl: widget.bookModel?.volumeInfo
                                                .imageLinks.thumbnail ??
                                            '',
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tap to view details',
                                        style: TextStyle(
                                          color: Color(0xFFA855F7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFA855F7)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Color(0xFFA855F7)
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'View Book',
                                              style: TextStyle(
                                                color: Color(0xFFA855F7),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              HugeIcons
                                                  .strokeRoundedArrowRight01,
                                              color: Color(0xFFA855F7),
                                              size: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 4),

                    // Message Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedCheckmarkCircle02,
                          color: Color(0xFFA855F7),
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'AI Recommendation',
                          style: TextStyle(
                            color: Color(0xFFA855F7),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getShortDescription(String description) {
    if (description.length <= 100) return description;
    return '${description.substring(0, 100)}...';
  }
}
