# Search-Signal-CryptoBot
Описание Search Signal CryptoBot v.1.0.
Читать до конца.

Рынок криптовалют имеет высокую степень валотивности.
По наблюдениям автора, более 90% операций на рынке осуществляется специальными программами (криптоботы), которые располагают 95%+ объемами.

Когда выходит важная новость на рынке криптовалют или банальный памп/дамп именно боты первыми начинают торги, в эти минуты валотивность зашкаливает.

Обычные пользователи успевают только наблюдать резкий рост/падения цены, даже трейдеры с 6 мониторами не успевают открывать позиции, биржи в эти секунды жутко тормозят, ордера выполняются с задержкой. Когда начинающие трейдеры входят в рынок, криптоботы уже закрывают позиции и рынок делает откат. И далее может быть новая волна. Нет смысла бежать искать новость, из-за которой произошел скачок цены, и крупных игроков может быть инсайдерская информация и они уже открывают большие позиции в предверии выхода новости. Цена биткоина может за пару минут вырасти от нескольких сотен долларов, до тысяч, например 12.04.18 (+18%), 10.06.18 (-7%), 17.07.18 (+10%), ZEC 28.09.17 (+63%).

И как бывает обидно, когда ты в эти минуты спишь или попиваешь пивко. Да и 6 мониторов тебя не спасут, невозможно же каждую секунду пялиться в мониторы. 

Данная программа (криптобот) выполняет главные задачи:
1. Следит в режиме реального времени за котировками пар.
2. Анализирует изменение цены, объемы и оповещает пользователя сигналами.
3. Посредством API-ключей пользователь может "одним кликом" открыть позицию, а в будущем, можно настроить и на автоматическое открытие/закрытие позиций.

По состоянию на август 2018 года, программа имеет три пары валют и котировки одной биржи.

После запуска программы, на главной форме загружаются котировки пар BTC/USD, ZEC/USD, ETH/USD. Котировки берутся с биржи Bitfinex. Для этого используется движок браузера Chrome, отсюда и большой "вес" программы.
 
Используются три инструмента анализа валотивности:
а) "Объем торгов" - количество сделок за единицу времени. Выражается в процентном отношении.
б) "Объем last сделки" - отношение изменения цены последней котировки к предыдущей. Выражается в процентном отношении. 
в) "Памп или дамп" - направление движения цены за относительно короткое время. Принимает значение от 0 до 200.  Стрелка маятника в покое находится на значении 100, в случае начала пампа, стрелка начнет опускаться вправо к 200, аналогично и с дампом, стрелка будет смещаться к 0. 
Все три инструмента со временем стремятся к своим начальным значениям.

Ниже размещается информация о текущем сигнале.

Криптобот на основе трех инструментов анализирует изменение цены и дает сигналы ко входу в рынок.     
Сигналы могут быть следующими, ниже приведены по степени важности:
1. "Наблюдение";
2. "Малые объемы торговли при значительно изменяющейся цене";
3. "Малые объемы торговли при сильно изменяющейся цене";
4. "Большие объемы торговли при отсутствии изменения цены";
5. "Большие объемы торговли при значительно изменяющейся цены";
6. "Большие объемы торговли при сильно изменяющейся цены";
7. "Большие объемы торговли при быстро и значительно изменяющейся цены";
8. "Большие объемы торговли при быстро и сильно изменяющейся цены";
9. "Аномальные объемы торговли при отсутствии изменения цены";
10. "Аномальные объемы торговли при значительно изменяющейся цены";
11. "Аномальные объемы торговли при сильно изменяющейся цены";
12. "Аномальные объемы торговли при быстро и значительно изменяющейся цены";
13. "Памп(Дамп) на малых объемах!";
14. "Памп(Дамп) на больших объемах";
15. "Памп(Дамп) на аномальных объемах!";
   
Сигналы сопровождаются соответствующим звуковым сигналом.
Котировки цен и сигналы также записываются в окно лога и в файл на диске.

В нижней части программы можно посмотреть свой баланс (доступен для биржи Bittrex и Bitfinex).
В правой части программы можно автоматически торговать в "один клик".

В меню настройки программы (CTRL+s) можно настроить:
1. Вкл/выкл звукового сигнала.
2. Отправка сигнала на e-mail (для этого требуется авторизоваться. ВНИМАНИЕ!: Во избежание недоразумений, создайте новую почту, с которой будет идти отправка сигналов! Не вводите данные основной почты!)
3. Вкл/выкл ведение логов.
4. Подключение ключей API бирж (ВНИМАНИЕ!: Во избежание недоразумений, не вставляйте свои ключи! Или настраивайте только на чтение баланса!).
5. Возможность включения функции симуляции цены. Это значит, что вы можете в главной форме программы, под котировкой изменять цену, чтобы понять принцип работы программы и как работают сигналы. Набрали цену (или "колесиком" мыши) и нажали "Enter".

Рекомендации.
Данная программа не панацея, тем не менее, экономит кучу времени и мониторов. Может следить за ценой десятков криптовалют, не пропустит ни одного пампа. О влиянии той или иной новости вы узнаете первыми в ту же секунду. Новость может еще не выйти, а настроение рынка уже будет проанализировано.  
Программа в будущем может самостоятельно открывать позиции, но лучше смотреть на структуру графика самому и начинать торговлю первым, используя для этого "один клик". 

Автор рекомендует торговать на биржах, имеющих возможность играть на понижении (шортить). Используя большой объем, при необходимости плечо.

Сделка не должна быть дольше 1 часа, чаще всего это должно быть пару минут. Если после скачка, цена остановилась, лучше закрыть позицию, потеряв только комиссию. Обязательно выставлять stop-ордера, но их достаточно ставить до 0,5-1% от цены открытия. Так как вход в памп/дамп рынка не предполагает что будет моментальный разворот рынка. Если судить по истории цен, сделок не должно быть больше 1-2 в неделю на каждую пару. Также, в момент резкого колебания цены биткоина, автор рекомендует открывать позицию других пар, так как они привязаны к цене биткойна и через несколько секунд так или иначе последуют за биткойном.
   
В планах у автора:
1. Добавить множество других пар, в том числе котировку с разных бирж.
2. Разработать мобильное приложение для отправки и приема сигналов.
3. Разработать коммерческую версию, в том числе версию сайта, через подписку получения только сигналов, telegram-бота.

Ограничения данной версии:
Программа не будет в свободном доступе, по двум причинам:
1. Автор не планировал с самого начала делиться разработкой, только идеей! Тем более бесплатно.
2. Дабы избежать нападок со стороны хейтеров и простых юзеров кричащих: "там есть вирусы!, он ворует наши ключи!". 

Тем не менее, демо-версию с исходниками(!) автор любезно выложил на GitHub 

Рекомендации, предложения, сотрудничество: 
www.сергей.бел,
sir85@bk.ru

ПРИМЕЧАНИЯ:
Большой "вес" программы обусловлен в первую очередь использования движка Chrome для получения котировок.
Для успешного компилирования вам потребуется:
Delphi XE5;
Windows 7 (64)
Компонент TChromium (где брал, не помню);
Компонент для скинов AlphaControls  (http://www.alphaskins.com/index_rus.php).
