import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String selectedCategory = 'Teknologi';
  double uploadProgress = 0.0;
  bool isUploading = false;

  final List<String> categories = ['Teknologi', 'Pendidikan', 'Lingkungan', 'Sosial', 'Kesehatan'];

  void _handleUpload() {
    setState(() {
      isUploading = true;
      uploadProgress = 0.0;
    });

    // Simulate upload
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        uploadProgress += 0.05;
      });
      if (uploadProgress >= 1.0) {
        setState(() {
          isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ide Inovasi Berhasil Diunggah! 🚀'),
            backgroundColor: AppColors.cyan,
          ),
        );
        return false;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'Unggah Ide'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Upload Placeholder
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.3), width: 1, style: BorderStyle.solid),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, size: 50, color: AppColors.cyan),
                    const SizedBox(height: 12),
                    Text(
                      'Pilih Video Inovasi',
                      style: AppTextStyles.heading(fontSize: 18),
                    ),
                    Text(
                      'Format MP4, maks. 60 detik',
                      style: AppTextStyles.caption(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Form Fields
            Text('Judul Ide', style: AppTextStyles.label(color: Colors.white)),
            const SizedBox(height: 8),
            _buildTextField(_titleController, 'Contoh: Smart Waste Bin AI'),

            const SizedBox(height: 16),

            Text('Deskripsi Ide', style: AppTextStyles.label(color: Colors.white)),
            const SizedBox(height: 8),
            _buildTextField(_descController, 'Jelaskan masalah dan solusi yang kamu tawarkan...', maxLines: 4),

            const SizedBox(height: 16),

            Text('Kategori', style: AppTextStyles.label(color: Colors.white)),
            const SizedBox(height: 8),
            _buildCategoryDropdown(),

            const SizedBox(height: 32),

            // Upload Progress
            if (isUploading) ...[
              LinearProgressIndicator(
                value: uploadProgress,
                backgroundColor: AppColors.cardDark,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
              ),
              const SizedBox(height: 8),
              Center(child: Text('${(uploadProgress * 100).toInt()}% Mengunggah...', style: AppTextStyles.caption())),
              const SizedBox(height: 24),
            ],

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.body(color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cyan, width: 1)),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          dropdownColor: AppColors.cardDark,
          items: categories.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) setState(() => selectedCategory = val);
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: isUploading ? null : _handleUpload,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.purple.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Center(
          child: Text(
            isUploading ? 'Sedang Memproses...' : 'Publikasikan Inovasi',
            style: AppTextStyles.heading(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
