# Generated by Django 3.0.8 on 2020-08-01 12:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('libmate_admin', '0003_auto_20200801_1240'),
    ]

    operations = [
        migrations.AlterField(
            model_name='book',
            name='isbn',
            field=models.CharField(max_length=13, null=True, verbose_name='ISBN Number'),
        ),
        migrations.AlterField(
            model_name='journal',
            name='issn',
            field=models.CharField(max_length=13, null=True, verbose_name='ISSN'),
        ),
    ]