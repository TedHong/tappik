import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:tappik/model/section_model.dart';
import 'package:tappik/model/story_model.dart';

class MainController extends GetxController {
  MenuType menuType = MenuType.SECTION;

  String _actionType = "add"; // 행동 타입 : add, edit

  String _sectionId = "";
  SectionModel? _sectionData; // = SectionModel.getDefaultModel();

  String _storyId = "";
  StoryModel? _storyData; // = StoryModel.getDefaultModel();

  //메뉴 상태 변경
  void setMenu(menu) {
    menuType = menu;
    update();
  }

  // 행동 타입 리턴
  getActionType() {
    return _actionType;
  }

  // section 관련
  void setSctionData(type, {id, sectionData}) {
    _sectionId = id!;
    _sectionData = sectionData!;
    _actionType = type!;
  }

  SectionModel getSectionData() {
    _sectionData ??= SectionModel.getDefaultModel();
    return _sectionData!;
  }

  getSectionId() {
    return _sectionId;
  }
  // end

  // story 관련
  void setStoryData(type, {id, storyData}) {
    _storyData = storyData;
    _actionType = type!;
    _storyId = id;
  }

  StoryModel getStoryData() {
    _storyData ??= StoryModel.getDefaultModel();
    return _storyData!;
  }

  getStoryId() {
    return _storyId;
  }

  // end
}

enum MenuType {
  SECTION,
  EDIT_SECTION,
  STORY,
  EDIT_STORY,
}
