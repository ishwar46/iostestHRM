part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileDetailsLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class MasterDetailsLoaded extends ProfileState {
  final EmployeePersonalDetailsResponse? employeePersonalDetailsResponse;
  final List<FamilyDetailsResponse>? familyList;
  final List<QualificationDetailsResponse>? qualificationList;
  final List<ExperienceDetailsResponse>? experienceList;
  final List<EmployeeSkillDetailsResponse>? skillsList;
  final List<EmployeeDocumentsDetailsResponse>? documentsList;
  final List<EmployeeBenefitsDetailsResponse>? benefitsList;
  final List<EmployeeRCTDetailsResponse>? rctList;
  final List<EmployeeAwardsDetailsResponse>? awardsList;
  final List<EmployeeWarningDetailsResponse>? warningList;
  final List<EmployeePaymentDetailsResponse>? paymentList;

  const MasterDetailsLoaded(
      this.employeePersonalDetailsResponse,
      this.familyList,
      this.qualificationList,
      this.experienceList,
      this.skillsList,
      this.documentsList,
      this.benefitsList,
      this.rctList,
      this.awardsList,
      this.warningList,
      this.paymentList);
  @override
  List<Object?> get props => [
        employeePersonalDetailsResponse,
        familyList,
        qualificationList,
        experienceList,
        skillsList,
        documentsList,
        benefitsList,
        rctList,
        awardsList,
        warningList,
        paymentList
      ];
}

class MasterDetailsLoadFailed extends ProfileState {
  final String message;

  const MasterDetailsLoadFailed(this.message);
  @override
  List<Object?> get props => [message];
}
