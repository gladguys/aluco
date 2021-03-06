enum CallStatus { PRESENTE, FALTA, FALTA_JUSTIFICADA, FERIADO, NENHUMA }

CallStatus getCallStatusFromString(String callStatusString) {
  switch (callStatusString) {
    case 'PRESENTE':
      return CallStatus.PRESENTE;
    case 'FALTA':
      return CallStatus.FALTA;
    case 'FALTA_JUSTIFICADA':
      return CallStatus.FALTA_JUSTIFICADA;
    case 'FERIADO':
      return CallStatus.FERIADO;
    case 'NENHUMA':
      return CallStatus.NENHUMA;
    default:
      return CallStatus.PRESENTE;
  }
}

CallStatus getCallStatusFromInt(int index) {
  switch (index) {
    case 0:
      return CallStatus.PRESENTE;
    case 1:
      return CallStatus.FALTA;
    case 2:
      return CallStatus.FALTA_JUSTIFICADA;
    case 3:
      return CallStatus.FERIADO;
    case 4:
      return CallStatus.NENHUMA;
    default:
      return CallStatus.PRESENTE;
  }
}

int getIntFromCallStatus(CallStatus callStatus) {
  return callStatus.index;
}
