class conss {
  final String? concert_name;
  final String? style;
  final String? image;
  final String? price_ticket;
  final String? ticket;
  final String? event_date;
  final String? event_time;
  final String? venue;
  final String? map;
  final String? name_art;

  conss({
    required this.concert_name,
    required this.style,
    required this.image,
    required this.price_ticket,
    required this.ticket,
    required this.event_date,
    required this.event_time,
    required this.venue,
    required this.map,
    required this.name_art,
  });

  factory conss.fromJson(Map<String, dynamic> json) {
    return conss(
      concert_name: json['concert_name'] ?? '',
      style: json['style'] ?? '',
      image: json['image'] ?? '',
      price_ticket: json['price_ticket'] ?? '',
      ticket: json['ticket'] ?? '',
      event_date: json['event_date'] ?? '',
      event_time: json['event_time'] ?? '',
      venue: json['venue'] ?? '',
      map: json['map'] ?? '',
      name_art: json['name_art'] ?? '',
    );
  }
}