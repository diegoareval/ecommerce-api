Swagger::Docs::Config.register_apis({
    '1.0' => {
      controller_base_path: '',
      api_file_path: 'public/api/v1/',
      base_path: 'http://localhost:3000',
      clean_directory: true,
    },
  })