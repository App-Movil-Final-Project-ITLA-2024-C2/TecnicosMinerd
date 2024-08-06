import 'package:sqflite/sqflite.dart';

class VisitTypeSeeder {
  static Future<void> seed(Database db) async {
    List<Map<String, dynamic>> visitTypes = [
      {
        'name': 'Supervisión General',
        'description': 'Evaluación y monitoreo de las actividades escolares para asegurar que se cumplan los objetivos educativos y normativas institucionales.'
      },
      {
        'name': 'Evaluación Docente',
        'description': 'Análisis detallado del desempeño de los docentes, incluyendo la observación de clases, revisión de planes de lección y retroalimentación sobre prácticas pedagógicas.'
      },
      {
        'name': 'Inspección de Infraestructura',
        'description': 'Revisión física de las instalaciones escolares, incluyendo aulas, laboratorios, y áreas comunes, para verificar el estado de mantenimiento y la adecuación de los recursos.'
      },
      {
        'name': 'Asesoramiento Pedagógico',
        'description': 'Consulta y guía para la implementación de nuevas metodologías de enseñanza, proporcionando estrategias y recursos para mejorar la calidad educativa.'
      },
      {
        'name': 'Capacitación del Personal',
        'description': 'Programa de formación y desarrollo profesional para el personal docente y administrativo, enfocado en nuevas técnicas educativas, gestión escolar y habilidades administrativas.'
      },
      {
        'name': 'Apoyo Psicológico',
        'description': 'Intervenciones y asistencia para el bienestar emocional de los estudiantes y el personal, incluyendo sesiones de apoyo, talleres y estrategias para manejar el estrés y otras dificultades.'
      },
      {
        'name': 'Revisión de Recursos',
        'description': 'Evaluación de los recursos educativos disponibles, tales como libros de texto, tecnología y materiales didácticos, para asegurar que sean adecuados y suficientes para los objetivos curriculares.'
      },
      {
        'name': 'Seguimiento de Proyectos Educativos',
        'description': 'Monitoreo y evaluación del progreso de proyectos educativos en ejecución, asegurando el cumplimiento de metas y proporcionando apoyo para resolver problemas que puedan surgir.'
      },
      {
        'name': 'Evaluación de Seguridad Escolar',
        'description': 'Inspección de las medidas de seguridad en el entorno escolar, incluyendo protocolos de emergencia, procedimientos de evacuación y el estado de los sistemas de seguridad.'
      },
      {
        'name': 'Apoyo Administrativo',
        'description': 'Asistencia en la gestión administrativa de la escuela, ayudando a optimizar procesos, mejorar la organización interna y apoyar en la implementación de políticas institucionales.'
      },
      {
        'name': 'Revisión de Documentación Escolar',
        'description': 'Verificación de la documentación y los registros escolares, incluyendo expedientes de estudiantes, informes académicos y otros documentos administrativos importantes.'
      },
      {
        'name': 'Promoción de Actividades Extracurriculares',
        'description': 'Fomento de actividades fuera del currículo regular, como clubes, eventos deportivos y culturales, para enriquecer la experiencia educativa de los estudiantes.'
      },
      {
        'name': 'Orientación Vocacional',
        'description': 'Orientación y asesoría para los estudiantes en la elección de sus trayectorias educativas y profesionales futuras, proporcionando información y recursos sobre opciones de carrera.'
      },
      {
        'name': 'Evaluación de Rendimiento Académico',
        'description': 'Análisis del rendimiento académico de los estudiantes, utilizando pruebas, evaluaciones y análisis de resultados para identificar áreas de mejora y éxito.'
      },
      {
        'name': 'Coordinación de Actividades Educativas',
        'description': 'Organización y coordinación de actividades entre diferentes niveles educativos y áreas curriculares para asegurar una integración efectiva y el cumplimiento de los objetivos educativos.'
      },
      {
        'name': 'Apoyo a la Inclusión Educativa',
        'description': 'Apoyo en la implementación de políticas y prácticas inclusivas para asegurar que todos los estudiantes, independientemente de sus habilidades o antecedentes, reciban una educación equitativa.'
      },
      {
        'name': 'Evaluación de Planes de Estudio',
        'description': 'Revisión y ajuste de los planes de estudio para asegurar que cumplan con los estándares educativos y las necesidades de los estudiantes, incorporando nuevas tendencias y enfoques pedagógicos.'
      },
      {
        'name': 'Revisión de Protocolos Sanitarios',
        'description': 'Inspección de las medidas sanitarias implementadas en la escuela, asegurando el cumplimiento de las normativas de salud y seguridad para prevenir y controlar enfermedades.'
      },
      {
        'name': 'Evaluación de Metodologías de Enseñanza',
        'description': 'Análisis de las metodologías de enseñanza utilizadas en las aulas para determinar su eficacia, hacer recomendaciones para mejoras y asegurar que se adapten a las necesidades de los estudiantes.'
      },
      {
        'name': 'Evaluación de Estrategias de Comunicación',
        'description': 'Revisión de las estrategias de comunicación entre la escuela y las familias, incluyendo la eficacia de los canales de comunicación y la participación de los padres en la educación.'
      },
      {
        'name': 'Monitoreo de Planes de Acción Correctiva',
        'description': 'Seguimiento de los planes de acción correctiva implementados para abordar problemas o deficiencias identificadas en evaluaciones previas, asegurando que se implementen adecuadamente y se logren los resultados deseados.'
      },
    ];

    for (var visitType in visitTypes) {
      await db.insert('visit_types', visitType);
    }
  }
}
