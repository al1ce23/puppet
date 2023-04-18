class disable_pdf_viewer {

  registry_key { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla':
    ensure => present,
  }

  registry_key { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\Firefox':
    ensure => present,
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\Firefox\DisableBuiltinPDFViewer':
    ensure => present,
    type   => 'dword',
    data   => '1',
  }

  registry_key { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge':
    ensure => present,
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\AlwaysOpenPdfExternally':
    ensure => present,
    type   => 'dword',
    data   => '1',
  }

  registry_key { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google':
    ensure => present,
  }

  registry_key { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome':
    ensure => present,
  }

  registry_value { 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\AlwaysOpenPdfExternally':
    ensure => present,
    type   => 'dword',
    data   => '1',
  }
}
