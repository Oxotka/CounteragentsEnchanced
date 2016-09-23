﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура Задолженность_ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущаяДата = ТекущаяДатаСеанса();
	
КонецПроцедуры

&НаСервере
Процедура Задолженность_ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	СвернутьРазвернутьПанель(СвернутьПанель);
	
КонецПроцедуры

&НаКлиенте
Процедура Задолженность_ОбработкаНавигационнойСсылки(НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	ПользовательскиеНастройки = ПользовательскиеНастройкиДляРасшифровки(ЭтотОбъект);
	ДополнительныеСвойства = ПользовательскиеНастройки.ДополнительныеСвойства;
	
	НастройкаГруппировки = Новый Массив;
	СтрокаДляРасшифровки = Новый Структура;
	СтрокаДляРасшифровки.Вставить("Использование", 	Истина);
	СтрокаДляРасшифровки.Вставить("Поле", 			"Документ");
	СтрокаДляРасшифровки.Вставить("Представление", 	"Документ");
	СтрокаДляРасшифровки.Вставить("ТипГруппировки", 0);
	НастройкаГруппировки.Добавить(СтрокаДляРасшифровки);
	
	ДополнительныеСвойства.Вставить("Группировка", НастройкаГруппировки);
	
	НастройкаОтбора = ПользовательскиеНастройки.Элементы.Добавить(Тип("ОтборКомпоновкиДанных"));
	НастройкаОтбора.ИдентификаторПользовательскойНастройки = "Отбор";
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(НастройкаОтбора, "Контрагент", ТекущиеДанные.Контрагент, ВидСравненияКомпоновкиДанных.Равно);
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("РежимРасшифровки",          Истина);
	ПараметрыОтчета.Вставить("ВидРасшифровки",            2);
	ПараметрыОтчета.Вставить("ПользовательскиеНастройки", ПользовательскиеНастройки);
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ЗадолженностьПоставщикам" ИЛИ НавигационнаяСсылкаФорматированнойСтроки = "ЗадолженностьПокупателей" Тогда
		Если ЭтоПокупатель Тогда 
			ДополнительныеСвойства.Вставить("КлючВарианта", "ЗадолженностьПокупателей");
			ОткрытьФорму("Отчет.ЗадолженностьПокупателей.Форма.ФормаОтчета", ПараметрыОтчета, ЭтотОбъект);
		Иначе
			ДополнительныеСвойства.Вставить("КлючВарианта", "ЗадолженностьПоставщикам");
			ОткрытьФорму("Отчет.ЗадолженностьПоставщикам.Форма.ФормаОтчета", ПараметрыОтчета, ЭтотОбъект);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Задолженность_ДекорацияСвернутьНажатие(Элемент)
	
	СвернутьПанель = НЕ СвернутьПанель;
	СвернутьРазвернутьПанель(СвернутьПанель);
	
КонецПроцедуры

&НаКлиенте
Процедура Задолженность_ДекорацияРазвернутьНажатие(Элемент)
	
	СвернутьПанель = НЕ СвернутьПанель;
	СвернутьРазвернутьПанель(СвернутьПанель);
	
КонецПроцедуры

&НаКлиенте
Процедура Задолженность_СписокПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ПриАктивизацииСтроки", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПриАктивизацииСтроки()
	
	Если СвернутьПанель Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РазместитьДанныеКонтрагента(ТекущиеДанные.Контрагент);
	
КонецПроцедуры

&НаСервере
Процедура РазместитьДанныеКонтрагента(Знач Контрагент)
	
	ДанныеКонтрагента = ДанныеДляЗаполненияПоКонтрагенту(Контрагент);
	Элементы.ДекорацияНаименованиеПолное.Заголовок = ДанныеКонтрагента.НаименованиеПолное;
	Элементы.ДекорацияДолгНам.Заголовок = НадписьВзаиморасчетов(ДанныеКонтрагента.Дебиторка, "Дт");
	Элементы.ДекорацияДолгНаш.Заголовок = НадписьВзаиморасчетов(ДанныеКонтрагента.Кредиторка, "Кт");
	ЭтоПокупатель = ДанныеКонтрагента.ЭтоПокупатель;
	
КонецПроцедуры

&НаСервере
Процедура СвернутьРазвернутьПанель(СвернутьПанель)
	
	Если СвернутьПанель Тогда
		Элементы.ПанельИнформации.Видимость = Ложь;
		Элементы.ГруппаЗаглушка.Видимость   = Истина;
	Иначе
		Элементы.ПанельИнформации.Видимость = Истина;
		Элементы.ГруппаЗаглушка.Видимость   = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДанныеДляЗаполненияПоКонтрагенту(Знач Контрагент)
	
	ДанныеКонтрагента = Новый Структура;
	ДанныеКонтрагента.Вставить("НаименованиеПолное", "Выберете контрагента");
	ДанныеКонтрагента.Вставить("Дебиторка",          0);
	ДанныеКонтрагента.Вставить("Кредиторка",         0);
	ДанныеКонтрагента.Вставить("ЭтоПокупатель",      Истина);
	
	Если НЕ ЗначениеЗаполнено(Контрагент) ИЛИ ТипЗнч(Контрагент) <> Тип("СправочникСсылка.Контрагенты") Тогда
		Возврат ДанныеКонтрагента;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Хозрасчетный.Ссылка
	|ПОМЕСТИТЬ СчетаУчетаРасчетов
	|ИЗ
	|	ПланСчетов.Хозрасчетный КАК Хозрасчетный
	|ГДЕ
	|	Хозрасчетный.Ссылка В(&СписокСчетов)
	|	И НЕ Хозрасчетный.Валютный
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Контрагенты.Ссылка,
	|	Контрагенты.НаименованиеПолное
	|ПОМЕСТИТЬ ВТКонтрагенты
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	Контрагенты.Ссылка = &Контрагент
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЕСТЬNULL(ХозрасчетныйОстатки.СуммаОстатокДт, 0) КАК Дебиторка,
	|	ЕСТЬNULL(ХозрасчетныйОстатки.СуммаОстатокКт, 0) КАК Кредиторка,
	|	ВТКонтрагенты.НаименованиеПолное,
	|	ВТКонтрагенты.Ссылка КАК Контрагент,
	|	ВЫБОР
	|		КОГДА ХозрасчетныйОстатки.Субконто2.ВидДоговора В (&ВидыДоговоровПокупателей)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ЭтоПокупатель
	|ИЗ
	|	ВТКонтрагенты КАК ВТКонтрагенты
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрБухгалтерии.Хозрасчетный.Остатки(
	|				,
	|				Счет В ИЕРАРХИИ
	|					(ВЫБРАТЬ
	|						СчетаУчетаРасчетов.Ссылка
	|					ИЗ
	|						СчетаУчетаРасчетов КАК СчетаУчетаРасчетов),
	|				&СубконтоКонтрагентДоговор,
	|				Субконто1 = &Контрагент) КАК ХозрасчетныйОстатки
	|		ПО ВТКонтрагенты.Ссылка = ХозрасчетныйОстатки.Субконто1";
	
	СубконтоКонтрагентДоговор = Новый СписокЗначений;
	СубконтоКонтрагентДоговор.Добавить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Контрагенты);
	СубконтоКонтрагентДоговор.Добавить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Договоры);
	
	СписокДоступныхОрганизаций = ОбщегоНазначенияБПВызовСервераПовтИсп.ВсеОрганизацииДанныеКоторыхДоступныПоRLS(Ложь);
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	Запрос.УстановитьПараметр("СубконтоКонтрагентДоговор", СубконтоКонтрагентДоговор);
	Запрос.УстановитьПараметр("СписокСчетовСПокупателями", МониторРуководителя.СчетаРасчетовСКонтрагентами(1));
	Запрос.УстановитьПараметр("СписокСчетовСПоставщиками", МониторРуководителя.СчетаРасчетовСКонтрагентами(2));
	СписокСчетов = МониторРуководителя.СчетаРасчетовСКонтрагентами(1);
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(СписокСчетов, МониторРуководителя.СчетаРасчетовСКонтрагентами(2), Истина);
	Запрос.УстановитьПараметр("СписокСчетов", СписокСчетов);
	Запрос.УстановитьПараметр("ВидыДоговоровПокупателей", БухгалтерскиеОтчеты.ВидыДоговоровПокупателей());
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		ЗаполнитьЗначенияСвойств(ДанныеКонтрагента, Выборка);
		ДанныеКонтрагента.НаименованиеПолное = Контрагент.НаименованиеПолное;
	КонецЕсли;
	
	Возврат ДанныеКонтрагента;
	
КонецФункции

&НаСервереБезКонтекста
Функция НадписьВзаиморасчетов(Знач Сумма, Знач ДтКт)
	
	КрупныйШрифт = Новый Шрифт(,11);
	МелкийШрифт = Новый Шрифт(,8);
	
	КомпонентыФС = Новый Массив;
	Если ДтКт = "Кт" Тогда
		КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='Мы должны'") + " ", КрупныйШрифт));
		СсылкаНаОтчет = "ЗадолженностьПоставщикам";
	Иначе
		КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='Должен нам'") + " ", КрупныйШрифт));
		СсылкаНаОтчет = "ЗадолженностьПокупателей";
	КонецЕсли;
	
	СуммаСтрокой = Формат(Сумма, "ЧДЦ=2; ЧРД=,; ЧРГ=' '; ЧН=0,00");
	ПозицияРазделителя = СтрНайти(СуммаСтрокой, ",");
	КомпонентыЧисла = Новый Массив;
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Лев(СуммаСтрокой, ПозицияРазделителя), КрупныйШрифт));
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Сред(СуммаСтрокой, ПозицияРазделителя+1), МелкийШрифт));
	КомпонентыФС.Добавить(Новый ФорматированнаяСтрока(КомпонентыЧисла, , , , СсылкаНаОтчет));
	КомпонентыФС.Добавить(" " + Константы.ВалютаРегламентированногоУчета.Получить());
	
	Возврат Новый ФорматированнаяСтрока(КомпонентыФС, , ЦветаСтиля.ТекстВторостепеннойНадписи);
	
КонецФункции

&НаКлиенте
Функция ПользовательскиеНастройкиДляРасшифровки(Форма)
	
	НачалоПериода = НачалоМесяца(Форма.ТекущаяДата);
	КонецПериода = Форма.ТекущаяДата;
	
	// Инициализация пользовательских настроек
	// Добавим в настройки все параметры которые могут использоваться в отчетах руководителю
	ПользовательскиеНастройки = Новый ПользовательскиеНастройкиКомпоновкиДанных;
	ДополнительныеСвойства = ПользовательскиеНастройки.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("РежимРасшифровки", Истина);
	ДополнительныеСвойства.Вставить("Организация",      Неопределено);
	ДополнительныеСвойства.Вставить("НачалоПериода",    НачалоПериода);
	ДополнительныеСвойства.Вставить("КонецПериода",     КонецПериода);
	ДополнительныеСвойства.Вставить("Период",           Форма.ТекущаяДата);
	
	Возврат ПользовательскиеНастройки;
	
КонецФункции

#КонецОбласти

