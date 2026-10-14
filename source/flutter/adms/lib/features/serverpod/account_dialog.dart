import 'package:flutter/material.dart';
import 'dispatch_controller.dart';

class AccountDialog extends StatefulWidget {
  const AccountDialog({
    super.key,
    required this.controller,
    required this.mode,
  });
  final DispatchController controller;
  final String mode;
  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController(),
      _organization = TextEditingController(),
      _email = TextEditingController(),
      _password = TextEditingController(),
      _confirmation = TextEditingController(),
      _invite = TextEditingController();
  bool _saving = false, _visible = false;
  String? _error;
  @override
  void dispose() {
    for (final c in [
      _name,
      _organization,
      _email,
      _password,
      _confirmation,
      _invite,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(switch (widget.mode) {
      'organization' => 'Create your organization',
      'invitation' => 'Join or recover an account',
      _ => 'Sign in to ADMS',
    }),
    content: SizedBox(
      width: 420,
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.mode == 'organization')
                _field(_organization, 'Organization name'),
              if (widget.mode != 'login') _field(_name, 'Your name'),
              if (widget.mode == 'invitation')
                _field(_invite, 'Invitation or recovery code', maxLines: 2)
              else
                _field(_email, 'Email', email: true),
              TextFormField(
                key: const Key('account-password'),
                controller: _password,
                enabled: !_saving,
                obscureText: !_visible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _visible = !_visible),
                    icon: Icon(
                      _visible ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (v) =>
                    (v?.length ?? 0) < (widget.mode == 'login' ? 1 : 12)
                    ? 'Use at least 12 characters.'
                    : (v?.length ?? 0) > 128
                    ? 'Maximum 128 characters.'
                    : null,
              ),
              if (widget.mode != 'login')
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: TextFormField(
                    controller: _confirmation,
                    enabled: !_saving,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                    ),
                    validator: (v) =>
                        v != _password.text ? 'Passwords do not match.' : null,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                widget.mode == 'invitation'
                    ? 'Get an enrollment or account recovery code from your organization administrator.'
                    : 'Accounts are stored securely in your Serverpod organization.',
                style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: _saving ? null : () => Navigator.pop(context),
        child: const Text('Back'),
      ),
      FilledButton(
        onPressed: _saving ? null : _submit,
        child: Text(
          _saving
              ? 'Please wait…'
              : widget.mode == 'login'
              ? 'Sign in'
              : 'Continue',
        ),
      ),
    ],
  );
  Widget _field(
    TextEditingController c,
    String label, {
    bool email = false,
    int maxLines = 1,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: c,
      enabled: !_saving,
      maxLines: maxLines,
      keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (v) => (v?.trim().length ?? 0) < 2 ? 'Required.' : null,
    ),
  );
  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final c = widget.controller;
    final ok = switch (widget.mode) {
      'organization' => await c.registerOrganization(
        _organization.text,
        _name.text,
        _email.text,
        _password.text,
      ),
      'invitation' => await c.acceptInvite(
        _invite.text.trim(),
        _name.text,
        _password.text,
      ),
      _ => await c.login(_email.text, _password.text),
    };
    if (!mounted) return;
    if (ok) {
      final recovery = widget.controller.recoveryCode;
      if (widget.mode == 'organization' && recovery != null) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('Save your recovery code'),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Keep this one-time code privately. It can recover the administrator account if you lose the password.',
                  ),
                  const SizedBox(height: 16),
                  SelectableText(recovery),
                ],
              ),
            ),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('I saved the code'),
              ),
            ],
          ),
        );
        widget.controller.recoveryCode = null;
      }
      if (!mounted) return;
      Navigator.pop(context, true);
    } else {
      setState(() {
        _saving = false;
        _error = c.error;
      });
    }
  }
}
