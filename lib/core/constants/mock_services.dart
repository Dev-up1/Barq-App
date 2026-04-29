import 'package:flutter/material.dart';

enum ServiceTab { services, gaming }

class ServiceItem {
  const ServiceItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.subdivisions,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<String> subdivisions;
}

class GamingItem {
  const GamingItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });

  final String id;
  final String name;
  final String subtitle;
  final String icon;
  final List<Color> colors;
}

const telecomServices = <ServiceItem>[
  ServiceItem(
    id: 'yemen-mobile',
    name: 'يمن موبايل',
    icon: Icons.smartphone_rounded,
    color: Color(0xFF10B981),
    subdivisions: ['باقات', 'رصيد', 'فواتير'],
  ),
  ServiceItem(
    id: 'you',
    name: 'يو',
    icon: Icons.phone_android_rounded,
    color: Color(0xFF3B82F6),
    subdivisions: ['باقات', 'رصيد', 'فواتير'],
  ),
  ServiceItem(
    id: 'sabafon',
    name: 'سبأفون',
    icon: Icons.sim_card_rounded,
    color: Color(0xFFEF4444),
    subdivisions: ['باقات', 'رصيد'],
  ),
  ServiceItem(
    id: 'way',
    name: 'واي',
    icon: Icons.cell_tower_rounded,
    color: Color(0xFFF59E0B),
    subdivisions: ['باقات', 'رصيد'],
  ),
  ServiceItem(
    id: 'yemen-net',
    name: 'يمن نت',
    icon: Icons.wifi_rounded,
    color: Color(0xFF8B5CF6),
    subdivisions: ['باقات', 'فواتير'],
  ),
  ServiceItem(
    id: 'aden-net',
    name: 'عدن نت',
    icon: Icons.router_rounded,
    color: Color(0xFFEC4899),
    subdivisions: ['باقات', 'فواتير'],
  ),
  ServiceItem(
    id: 'electricity',
    name: 'الكهرباء',
    icon: Icons.flash_on_rounded,
    color: Color(0xFFFBBF24),
    subdivisions: ['فواتير'],
  ),
  ServiceItem(
    id: 'water',
    name: 'المياه',
    icon: Icons.water_drop_rounded,
    color: Color(0xFF06B6D4),
    subdivisions: ['فواتير'],
  ),
];

const gamingItems = <GamingItem>[
  GamingItem(
    id: 'pubg',
    name: 'PUBG Mobile',
    subtitle: 'شحن UC',
    icon: '🎮',
    colors: [Color(0xFFFB923C), Color(0xFFEF4444)],
  ),
  GamingItem(
    id: 'free-fire',
    name: 'Free Fire',
    subtitle: 'Diamonds',
    icon: '💎',
    colors: [Color(0xFF60A5FA), Color(0xFF8B5CF6)],
  ),
  GamingItem(
    id: 'jawaker',
    name: 'Jawaker',
    subtitle: 'رصيد جواكر',
    icon: '🎲',
    colors: [Color(0xFF4ADE80), Color(0xFF10B981)],
  ),
  GamingItem(
    id: 'fortnite',
    name: 'Fortnite',
    subtitle: 'V-Bucks',
    icon: '⚡',
    colors: [Color(0xFFA78BFA), Color(0xFFEC4899)],
  ),
];
