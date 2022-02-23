import '../models/report.dart';

class HtmlMailPage {
  final Report report;

  HtmlMailPage({
    required this.report
  });

  var imageSource = 'https://ibb.co/596F2p1';

  html() {
    return '''
        <head>
          <meta charset="UTF-8">
        </head>
        <body>
          <table style="margin: 3px; padding: 10px; font: 13px Tahoma, Arial, sans-serif; border: 1px solid #dbdddf; width: 810px; border-color:gray; border-width: 2px; border-style:dashed;border-radius: 5px 5px 5px 5px;-moz-border-radius: 5px 5px 5px 5px;-webkit-border-radius: 5px 5px 5px 5px;">
            <tr>
              <td>
                <table style="font: 13px Tahoma, Arial, sans-serif; ">
                  <tr>
                    <td style="text-align:right;">
                      <img src="http://a.radikal.ru/a34/2202/c0/14f586db7d80.png" width="200" height="100" alt="LOGO" align="right" />
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      № отчета
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.name}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 2000px; padding-bottom: 5px; vertical-align: top;">
                      Дата
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.date}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      Заказчик
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.company}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      Место расположения
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.place}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      Контактное лицо заказчика
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.customerPhone}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      Контактный номер телефона
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.customerPhone}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      Электронная почта
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.customerEmail}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <table style="font: 13px Tahoma, Arial, sans-serif;">
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                      Дата
                    </td>
                    <td colspan="2" style="vertical-align: top;">
                      <table style="width: 100%; font: 13px Tahoma, Arial, sans-serif;">
                        <tr>
                          <td style="width: 100%;"><b>${report.date}</b></td>
                          <td style="color: #077d00; font-weight: bold; text-align: right;"><span></span></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-bottom: 5px; border-top: 1px dotted #dbdddf;" colspan="3"></td>
                  </tr>
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                        Данные машины
                    </td>
                    <td style="vertical-align: top;">
                        <table style="margin: 0; padding: 0; font: 13px Tahoma, Arial, sans-serif;">
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                Модель
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.machineModel}
                              </td>
                            </tr>
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                Серийный номер
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.machineNumb}
                              </td>
                              <td style='padding-top: 5px; font-weight: bold; width: 35px; text-align: right;'>
                              
                              </td>
                            </tr>
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                Год выпуска
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.machineYear}
                              </td>
                            
                              <td style='padding-top: 5px; font-weight: bold; width: 35px; text-align: right;'>
                                
                              </td>
                            </td>  
                        </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-bottom: 5px; border-top: 1px dotted #dbdddf;" colspan="3"></td>
                  </tr>
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                        Данные двигателя
                    </td>
                    <td style="vertical-align: top;">
                        <table style="margin: 0; padding: 0; font: 13px Tahoma, Arial, sans-serif;">
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                Модель
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.engineModel}
                              </td>
                            </tr>
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                Серийный номер
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.engineNumb}
                              </td>
                              <td style='padding-top: 5px; font-weight: bold; width: 35px; text-align: right;'>
                              
                              </td>
                            </tr>
                        </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-bottom: 5px; border-top: 1px dotted #dbdddf;" colspan="3"></td>
                  </tr>
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                        Наработка
                    </td>
                    <td style="vertical-align: top;">
                        <table style="margin: 0; padding: 0; font: 13px Tahoma, Arial, sans-serif;">
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                двигателя
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.opTime_1} м*ч
                              </td>
                            </tr>
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                редуктора
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.opTime_2} м*ч
                              </td>
                            </tr>
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                в погонных метрах
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.opTime_3} м*ч
                              </td>
                            </tr>
                            <tr>
                              <td style="padding: 0; width: 160px; margin-right: 5px; color: #077d00; vertical-align: top; font-weight: bold;">
                                гусеничного движителя
                              </td>
                              <td colspan='2' style="vertical-align: top; width: 410px;">
                                ${report.opTime_4} м*ч
                              </td>
                              <td style='padding-top: 5px; font-weight: bold; width: 35px; text-align: right;'>
                              
                              </td>
                            </tr>
                        </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding-bottom: 5px; border-top: 1px dotted #dbdddf;" colspan="3"></td>
                  </tr>
                  <tr>
                    <td style="width: 200px; padding-bottom: 5px; vertical-align: top;">
                        Примечание
                    </td>
                    <td style="vertical-align: top;">
                        ${report.note}
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </body>
      ''';
  }

}