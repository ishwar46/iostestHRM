import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Profile/profile_bloc.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/login_service.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

String getFormattedDate(String dateTime) {
  final formatDate = DateFormat('yyyy-MM-dd');
  var parsedDate = DateTime.parse(dateTime);
  var formattedDate = formatDate.format(parsedDate);
  return formattedDate;
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage>
    with TickerProviderStateMixin {
  late ProfileBloc _profileBloc;
  late LoginService _loginService;
  late EmployeeService _employeeService;

  @override
  void initState() {
    _loginService = LoginService(Dio());
    _employeeService = EmployeeService(Dio());
    _profileBloc = ProfileBloc(_loginService, _employeeService);
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  String getInitials(String personName) => personName.isNotEmpty
      ? personName
          .trim()
          .replaceAll(RegExp(' +'), ' ')
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => _profileBloc..add(LoadMasterDetails())),
      ],
      child: Scaffold(
        body: DefaultTabController(
            length: 13,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    snap: false,
                    elevation: 0,
                    title: Text(
                      localization.acc_info,
                      style: const TextStyle(fontSize: 14),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.primary,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SliverPersistentHeader(
                      pinned: true, floating: true, delegate: MyTab())
                ];
              },
              body: const _tabViews(),
            )),
      ),
    );
  }
}

class _tabViews extends StatelessWidget {
  const _tabViews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      SingleChildScrollView(
        child: _masterTab(),
      ),
      SingleChildScrollView(
        child: _personalTab(),
      ),
      SingleChildScrollView(
        child: _contactTab(),
      ),
      SingleChildScrollView(
        child: _familyTab(),
      ),
      SingleChildScrollView(
        child: _qualificationTab(),
      ),
      SingleChildScrollView(
        child: _experienceTab(),
      ),
      SingleChildScrollView(
        child: _documentTab(),
      ),
      SingleChildScrollView(
        child: _skillTab(),
      ),
      SingleChildScrollView(
        child: _benefitTab(),
      ),
      SingleChildScrollView(
        child: _rctTab(),
      ),
      SingleChildScrollView(
        child: _awardTab(),
      ),
      SingleChildScrollView(
        child: _warningTab(),
      ),
      SingleChildScrollView(
        child: _paymentTab(),
      ),
    ]);
  }
}

class _masterTab extends StatelessWidget {
  const _masterTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            );
          }
          if (state is MasterDetailsLoaded) {
            var name = state.employeePersonalDetailsResponse?.name ??
                "Default Profile";
            var names = name.split(' ');
            String firstName = names[1];
            String lastName = names[3];
            if (state.employeePersonalDetailsResponse?.name == "") {
              return const _noData();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localization.first_name,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  firstName,
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.last_name,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  lastName,
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.emp_code,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.employeeCode ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.joined_date,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  getFormattedDate(
                      state.employeePersonalDetailsResponse!.joinedDate!),
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.rfid,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.rfid ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.mobile_no,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.mobileNumber ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.email_id,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.emailId ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.office_name,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.officeName ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.department,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.departmentName ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.designation,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.designationName ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.job_type,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.jobTypeName ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.work_shift,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.workShiftName ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}

class _paymentTab extends StatelessWidget {
  const _paymentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.paymentList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.payment_term,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.paymentList?[index].paymentTerm ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.mode_of_payment,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.paymentList?[index].paymentMode ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.bank_name,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.paymentList?[index].bankName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.account_no,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.paymentList?[index].accountNo ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.branch,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.paymentList?[index].branchName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: state.paymentList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _warningTab extends StatelessWidget {
  const _warningTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.warningList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.warning_type,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.warningList?[index].warningTypeName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.description,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.warningList?[index].description ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.date_given,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.warningList?[index].dateGiven ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.remarks,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.warningList?[index].remarks ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
              itemCount: state.warningList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _awardTab extends StatelessWidget {
  const _awardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.awardsList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.award_type,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.awardsList?[index].awardTypeName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.description,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.awardsList?[index].description ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.date_given,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.awardsList?[index].dateGiven ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.remarks,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.awardsList?[index].remarks ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
              itemCount: state.awardsList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _rctTab extends StatelessWidget {
  const _rctTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.rctList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.rct_type,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.rctList?[index].rctTypeName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.topic,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.rctList?[index].topic ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.journam_name,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.rctList?[index].journalName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.venue,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.rctList?[index].venue ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
              itemCount: state.rctList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _benefitTab extends StatelessWidget {
  const _benefitTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.benefitsList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.beneficiary,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.benefitsList?[index].beneficiaryName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.benefit,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.benefitsList?[index].benifitTypeName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.benefit_frequency,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.benefitsList?[index].benifitFrequencyName ??
                              "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.start_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.benefitsList?[index].startDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.end_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.benefitsList?[index].endDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: state.benefitsList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _skillTab extends StatelessWidget {
  const _skillTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.skillsList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.skill_category,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.skillsList?[index].skillCategoryName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.description,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.skillsList?[index].description ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.rating,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.skillsList?[index].rating ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.start_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.skillsList?[index].startDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.end_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.skillsList?[index].endDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: state.skillsList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _documentTab extends StatelessWidget {
  const _documentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.documentsList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.doc_type,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.documentsList?[index].documentTypename ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.doc_code,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.documentsList?[index].documentNo ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.doc_name,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.documentsList?[index].documentName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.issue_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.documentsList?[index].issueDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.expiry_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.documentsList?[index].expiryDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      color: AppColor.primary,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
              itemCount: state.documentsList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _experienceTab extends StatelessWidget {
  const _experienceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.experienceList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.designation,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.experienceList?[index].designationName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.country,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.experienceList?[index].countryName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.city,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.experienceList?[index].cityName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.start_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.experienceList?[index].startDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.end_date,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.experienceList?[index].endDate ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.job_profile,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.experienceList?[index].responsiblity ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: state.experienceList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _qualificationTab extends StatelessWidget {
  const _qualificationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.qualificationList!.isEmpty) {
              return const _noData();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.qualification,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColor.titleText,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                state.qualificationList?[index]
                                        .qualificationTypeName ??
                                    "N/A",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColor.lightText,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.uni_college,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.titleText)),
                              Text(
                                state.qualificationList?[index].university ??
                                    "N/A",
                                style: const TextStyle(
                                    fontSize: 12, color: AppColor.lightText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.specialization,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.titleText)),
                              Text(
                                state.qualificationList?[index]
                                        .specialization ??
                                    "N/A",
                                style: const TextStyle(
                                    fontSize: 12, color: AppColor.lightText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.percentage,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.titleText)),
                              Text(
                                state.qualificationList?[index].marks ?? "N/A",
                                style: const TextStyle(
                                    fontSize: 12, color: AppColor.lightText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.country,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.titleText)),
                              Text(
                                state.qualificationList?[index].countryName ??
                                    "N/A",
                                style: const TextStyle(
                                    fontSize: 12, color: AppColor.lightText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.city,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.titleText)),
                              Text(
                                state.qualificationList?[index].cityName ??
                                    "N/A",
                                style: const TextStyle(
                                    fontSize: 12, color: AppColor.lightText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.completion_date,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.titleText)),
                              Text(
                                state.qualificationList?[index]
                                        .completionDate ??
                                    "N/A",
                                style: const TextStyle(
                                    fontSize: 12, color: AppColor.lightText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            color: AppColor.primary,
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: state.qualificationList?.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                ),
              ],
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _familyTab extends StatelessWidget {
  const _familyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.familyList!.isEmpty) {
              return const _noData();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.name,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.familyList?[index].name ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.relation,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.familyList?[index].relationName ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.telephone,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.familyList?[index].telephone ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.mobile_no,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.familyList?[index].mobile ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.email,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          state.familyList?[index].email ?? "N/A",
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(localization.dob,
                            style: const TextStyle(
                                fontSize: 13, color: AppColor.titleText)),
                        Text(
                          getFormattedDate(state.familyList![index].birthDate!),
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      color: AppColor.primary,
                    ),
                  ],
                );
              },
              itemCount: state.familyList?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return const _noData();
          }
          return Container();
        },
      ),
    );
  }
}

class _contactTab extends StatelessWidget {
  const _contactTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _permanentContact(),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: AppColor.titleText,
            thickness: 1,
          ),
          _temporaryContact(),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: AppColor.titleText,
            thickness: 1,
          ),
          _emergencyContact(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class _emergencyContact extends StatelessWidget {
  const _emergencyContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.zero,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            return Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      localization.emergency,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.relation,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.relationNameE ??
                          "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.name,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.nameE ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.mobile_no,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.mobileE ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.email,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.emailE ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}

class _temporaryContact extends StatelessWidget {
  const _temporaryContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.zero,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        localization.temporary,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.country,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.countryNameT ??
                          "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.zone,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.zoneNameT ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.district,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.districtNameT ??
                          "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.city,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.cityNameT ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.tole,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.toleT ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.vdc_mun,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.vdcNameT ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.ward_no,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.wardNameT ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.address,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.addressT ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}

class _permanentContact extends StatelessWidget {
  const _permanentContact({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.zero,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        localization.permanent,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.country,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.countryNameP ??
                          "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.zone,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.zoneNameP ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.district,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.districtNameP ??
                          "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.city,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.cityNameP ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.tole,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.toleP ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.vdc_mun,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.vdcNameP ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.ward_no,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.wardNameP ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.address,
                        style: const TextStyle(
                            fontSize: 13, color: AppColor.titleText)),
                    Text(
                      state.employeePersonalDetailsResponse?.addressP ?? "N/A",
                      style: const TextStyle(
                          fontSize: 12, color: AppColor.lightText),
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}

class _personalTab extends StatelessWidget {
  const _personalTab({
    Key? key,
  }) : super(key: key);

  String getGender(int genderId) {
    if (genderId == 1) {
      return "Male";
    } else if (genderId == 2) {
      return "Female";
    } else {
      return "Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsLoading) {
            return const SizedBox(
              height: 10,
              width: 10,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MasterDetailsLoaded) {
            if (state.employeePersonalDetailsResponse?.birthDate == "") {
              return const _noData();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localization.dob,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  getFormattedDate(
                      state.employeePersonalDetailsResponse!.birthDate!),
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.blood_group,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.bloodGroupName ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.gender,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  getGender(state.employeePersonalDetailsResponse?.gender ?? 0),
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.height_weight,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.height ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.marital_status,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.maritalStatusName ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.nationality,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.nationalityname ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.religion,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.religionName ?? "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.mother_tongue,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.motherTongueName ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.offer_date,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  getFormattedDate(
                      state.employeePersonalDetailsResponse!.offerDate!),
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(localization.probation_period,
                    style: const TextStyle(
                        fontSize: 13, color: AppColor.titleText)),
                Text(
                  state.employeePersonalDetailsResponse?.probationPeriodName ??
                      "N/A",
                  style:
                      const TextStyle(fontSize: 12, color: AppColor.lightText),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          }
          if (state is MasterDetailsLoadFailed) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}

class MyTab extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double, bool) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(color: AppColor.primary),
      child: TabBar(
          isScrollable: true,
          labelColor: AppColor.whiteText,
          physics: const BouncingScrollPhysics(),
          automaticIndicatorColorAdjustment: true,
          unselectedLabelColor: AppColor.lightText,
          labelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              color: AppColor.whiteText,
            ),
          ),
          tabs: [
            Tab(
              text: localization.master,
            ),
            Tab(
              text: localization.personal,
            ),
            Tab(
              text: localization.contact,
            ),
            Tab(
              text: localization.family,
            ),
            Tab(
              text: localization.qualification,
            ),
            Tab(
              text: localization.experience,
            ),
            Tab(
              text: localization.document,
            ),
            Tab(
              text: localization.skill,
            ),
            Tab(
              text: localization.benefit,
            ),
            Tab(
              text: localization.rct,
            ),
            Tab(
              text: localization.award,
            ),
            Tab(
              text: localization.warning,
            ),
            Tab(
              text: localization.payment,
            ),
          ]),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double maxExtent = 80;
  @override
  double minExtent = 50;
}

class _noData extends StatelessWidget {
  const _noData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        LottieBuilder.asset("assets/lottie/emptybox.json", repeat: true),
        const SizedBox(
          height: 34,
        ),
        Text(localization.no_data)
      ],
    );
  }
}
