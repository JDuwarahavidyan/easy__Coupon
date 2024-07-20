part of 'qr_bloc.dart';

sealed class QrCodeEvent extends Equatable {
  const QrCodeEvent();

  @override
  List<Object> get props => [];
}

final class CreateQrCodeEvent extends QrCodeEvent {
  final QRModel qrCode;

  const CreateQrCodeEvent(this.qrCode);

  @override
  List<Object> get props => [qrCode];
}

final class QrCodeDeleteEvent extends QrCodeEvent {
  final String id;

  const QrCodeDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class QrCodeReadEvent extends QrCodeEvent {
  
  @override
  List<Object> get props => [];
}


final class QrCodeLoadEvent extends QrCodeEvent {
  final List<QRModel> qrcodes;

  const QrCodeLoadEvent(this.qrcodes);

  @override
  List<Object> get props => [qrcodes];
}


final class QrCodeReadAllEvent extends QrCodeEvent {
  const QrCodeReadAllEvent();

}

