abstract class ChatStates {}

class InitialChatStates extends ChatStates {}

class GetUserDataLoadingState extends ChatStates {}

class GetUserDataSuccessState extends ChatStates {}

class GetUserDataErrorState extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {}

class GetMessagesSuccessState extends ChatStates {}

class GetMessagesLoadingState extends ChatStates {}

//////////
class GetMessagesErrorState extends ChatStates {}

class UpdateTypingStatusState extends ChatStates {}
