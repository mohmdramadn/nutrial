import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrial/components/logo.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/screens/pdf/pdf_view_model.dart';
import 'package:provider/provider.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PdfViewModel>(
        create: (_) => PdfViewModel(), child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PdfViewModel>().createTableRowsInit();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = context.select((PdfViewModel vm) => vm.isLoading);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150.h,
                color: AppColors.primaryDarkColor,
                child: const Center(child: Logo()),
              ),
              Image.asset('assets/images/protiens.png', fit: BoxFit.cover),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const _ProteinsTable(),
              SizedBox(height: 50.h),
              Image.asset('assets/images/fats.png', fit: BoxFit.cover),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const _ProteinsTable(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProteinsTable extends StatelessWidget {
  const _ProteinsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var itemRows = context.select((PdfViewModel vm) => vm.itemsList);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FixedColumnWidth(size.width * 0.10),
            1: FixedColumnWidth(size.width * 0.50),
            2: FixedColumnWidth(size.width * 0.19),
            3: FixedColumnWidth(size.width * 0.19)
          },
          children: [
            for (var item in itemRows)
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0.h),
                    child: Text(
                      '${itemRows.indexWhere((element) => element == item) + 1}.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0.h),
                    child: Text(
                      item.itemName!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0.h),
                    child: Text(
                      item.itemQuantity.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 12.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0.h),
                    child: Text(
                      '${item.itemCalories} cal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
