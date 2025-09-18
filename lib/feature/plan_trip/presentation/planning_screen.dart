import 'package:flutter/material.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      body: Column(
        children: [
          const _PlanningHeader(),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -36),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 24,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 52,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Plan your trip',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        _DropdownOption(
                          label: 'Địa điểm',
                          value: 'Chọn tỉnh thành',
                          onTap: () => _showSearchPopup(context),
                        ),
                        const SizedBox(height: 20),
                        _DropdownOption(
                          label: 'Thời gian',
                          value: "Cho ngày đi - ngày về",
                          onTap: () => _showSchedulePopup(context),
                        ),
                        const SizedBox(height: 20),
                        _DropdownOption(
                          label: 'Khách',
                          value: "chọn số lượng thành viên",
                          onTap: () => _showGuestsPopup(context),
                        ),
                        const SizedBox(height: 20),
                        _DropdownOption(
                          label: 'Ngân sách',
                          value: "Lựa chọn mức ngân sách",
                          onTap: () => _showBudgetPopup(context),
                        ),
                        const SizedBox(height: 20), // Add some space at the bottom
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF357AF6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            minimumSize: const Size(double.infinity, 54),
          ),
          onPressed: () {
            // Handle next action
          },
          child: const Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  static void _showSearchPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('Search Popup')),
    );
  }

  static void _showBudgetPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('Budget Popup')),
    );
  }

  static void _showSchedulePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('Schedule Popup')),
    );
  }

  static void _showGuestsPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Center(child: Text('Guests Popup')),
    );
  }
}

class _PlanningHeader extends StatelessWidget {
  const _PlanningHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/banners/place_holder.JPG',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x40000000),
                        Color(0x00000000),
                        Color(0x66000000),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleIconButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }
}

class _DropdownOption extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DropdownOption({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF8F9FB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black45),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
